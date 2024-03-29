package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"strconv"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/go-chi/chi/v5"
)

type Response struct {
	PlaceId     int     `json:"place_id"`
	Licence     string  `json:"licence"`
	PoweredBy   string  `json:"powered_by"`
	OsmType     string  `json:"osm_type"`
	OsmId       int     `json:"osm_id"`
	Boundingbox []int   `json:"boundingbox"`
	Lat         string  `json:"lat"`
	Lon         string  `json:"lon"`
	DisplayName string  `json:"display_name"`
	Class       string  `json:"class"`
	Type        string  `json:"type"`
	Importance  float32 `json:"importance"`
}

func (app *App) Index(w http.ResponseWriter, r *http.Request) {
	enableCors(&w)
	fmt.Fprint(w, "Welcome!\n")
}

func (app *App) getVisited(w http.ResponseWriter, r *http.Request) {
	enableCors(&w)

	places, err := getVisited(app.Database)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, err.Error())
		return
	}

	respondWithJSON(w, http.StatusOK, places)

}

func (app *App) getToGo(w http.ResponseWriter, r *http.Request) {
	enableCors(&w)

	places, err := getToGo(app.Database)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, err.Error())
		return
	}

	respondWithJSON(w, http.StatusOK, places)

}

func (app *App) deletePlace(w http.ResponseWriter, r *http.Request) {
	enableCors(&w)

	place := chi.URLParam(r, "place")

	p := places{Place: place}

	photo, visited, err := p.getInfoVisited(app.Database)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, err.Error())
		return
	}

	if visited {
		deletePhoto(w, photo)
	}

	if err := p.deletePlace(app.Database); err != nil {
		respondWithError(w, http.StatusInternalServerError, err.Error())
		return
	}

	respondWithJSON(w, http.StatusOK, map[string]string{"result": "success"})
}

func deletePhoto(w http.ResponseWriter, filename string) {

	newSession, err := newSession()
	if err != nil {
		respondWithError(w, http.StatusBadRequest, err.Error())
	}
	if err != nil {
		respondWithError(w, http.StatusBadRequest, err.Error())
	}

	fileName, err := deleteFileInS3(newSession, filename)
	if err != nil {
		respondWithError(w, http.StatusBadRequest, "Could not delete file")
	} else {
		respondWithJSON(w, http.StatusCreated, "Image deleted successfully: "+fileName)
	}
}

func (app *App) addToGo(w http.ResponseWriter, r *http.Request) {
	enableCors(&w)

	var p places
	decoder := json.NewDecoder(r.Body)
	if err := decoder.Decode(&p); err != nil {
		respondWithError(w, http.StatusBadRequest, "Invalid request payload")
		return
	}
	defer r.Body.Close()

	lat, long := coordinates(w, p.Place)

	err := p.addToGo(app.Database, lat, long)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, err.Error())
		return
	}

	respondWithJSON(w, http.StatusCreated, p)
}

func (app *App) addVisited(w http.ResponseWriter, r *http.Request) {
	enableCors(&w)

	var p places
	decoder := json.NewDecoder(r.Body)
	if err := decoder.Decode(&p); err != nil {
		respondWithError(w, http.StatusBadRequest, "Invalid request payload")
		return
	}
	defer r.Body.Close()

	lat, long := coordinates(w, p.Place)

	err := p.addVisited(app.Database, lat, long, p.Photo)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, err.Error())
		return
	}

	respondWithJSON(w, http.StatusCreated, p)
}

func uploadPhoto(w http.ResponseWriter, r *http.Request) {
	enableCors(&w)

	maxSize := int64(10485760) // allow only 10MB of file size

	err := r.ParseMultipartForm(maxSize)
	if err != nil {
		respondWithError(w, http.StatusNotAcceptable, "Image too large. Max Size: "+strconv.FormatInt(maxSize, 10))
		return
	}

	file, fileHeader, err := r.FormFile("file")
	if err != nil {
		respondWithError(w, http.StatusBadRequest, err.Error())
		return
	}
	defer file.Close()

	newSession, err := newSession()
	if err != nil {
		respondWithError(w, http.StatusBadRequest, err.Error())
	}

	fileName, err := uploadFileToS3(newSession, file, fileHeader)
	if err != nil {
		respondWithError(w, http.StatusBadRequest, err.Error())
	} else {
		respondWithJSON(w, http.StatusCreated, "Image uploaded successfully: "+fileName)
	}
}

func coordinates(w http.ResponseWriter, addr string) (float32, float32) {

	url := "https://geocode.maps.co/search?q=" + addr

	resp, err := http.Get(url)
	if err != nil {
		respondWithError(w, http.StatusBadRequest, err.Error())
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		respondWithError(w, http.StatusBadRequest, err.Error())
	}

	var response []Response
	if err := json.Unmarshal(body, &response); err != nil { // Parse []byte to the go struct pointer
		lat, err := strconv.ParseFloat(response[0].Lat, 32)
		if err != nil {
			respondWithError(w, http.StatusBadRequest, err.Error())
		}
		long, err := strconv.ParseFloat(response[0].Lon, 32)
		if err != nil {
			respondWithError(w, http.StatusBadRequest, err.Error())
		}
		return float32(lat), float32(long)
	} else {
		respondWithError(w, http.StatusBadRequest, err.Error())
		return 0.0, 0.0
	}
}

func GetEnv(key, fallback string) string {
	value, exists := os.LookupEnv(key)
	if !exists {
		value = fallback
	}
	return value
}

func newSession() (*session.Session, error) {

	key := os.Getenv("SPACES_KEY")
	secret := os.Getenv("SPACES_SECRET")
	url := os.Getenv("SPACES_ENDPOINT_URL")

	value := GetEnv("FORCE_PATH_STYLE", "false")

	pathStyle, err := strconv.ParseBool(value)
	if err != nil {
		log.Fatal(err)
	}

	s3Config := &aws.Config{
		Credentials:      credentials.NewStaticCredentials(key, secret, ""),
		Endpoint:         aws.String(url),
		Region:           aws.String("us-east-1"),
		S3ForcePathStyle: aws.Bool(pathStyle),
	}

	newSession, err := session.NewSession(s3Config)

	return newSession, err
}
