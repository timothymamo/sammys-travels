package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strconv"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/codingsince1985/geo-golang/google"
	"github.com/go-chi/chi/v5"
)

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

	key := os.Getenv("SPACES_KEY")
	secret := os.Getenv("SPACES_SECRET")
	url := os.Getenv("SPACES_ENDPOINT_URL")

	s3Config := &aws.Config{
		Credentials:      credentials.NewStaticCredentials(key, secret, ""),
		Endpoint:         aws.String(url),
		Region:           aws.String("us-east-1"),
		S3ForcePathStyle: aws.Bool(false),
	}

	newSession, err := session.NewSession(s3Config)
	if err != nil {
		respondWithError(w, http.StatusBadRequest, err.Error())
	}

	fileName, err := deleteFileInS3(newSession, filename)
	if err != nil {
		respondWithError(w, http.StatusBadRequest, "Could not delete file")
	}

	respondWithJSON(w, http.StatusCreated, "Image deleted successfully: "+fileName)
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

	lat, long := coordinates(p.Place)

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

	lat, long := coordinates(p.Place)

	err := p.addVisited(app.Database, lat, long, p.Photo)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, err.Error())
		return
	}

	respondWithJSON(w, http.StatusCreated, p)
}

func uploadPhoto(w http.ResponseWriter, r *http.Request) {
	enableCors(&w)

	key := os.Getenv("SPACES_KEY")
	secret := os.Getenv("SPACES_SECRET")
	url := os.Getenv("SPACES_ENDPOINT_URL")
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

	s3Config := &aws.Config{
		Credentials:      credentials.NewStaticCredentials(key, secret, ""),
		Endpoint:         aws.String(url),
		Region:           aws.String("us-east-1"),
		S3ForcePathStyle: aws.Bool(false),
	}

	newSession, err := session.NewSession(s3Config)
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

func coordinates(addr string) (float32, float32) {

	geocoder := google.Geocoder(os.Getenv("GOOGLE_API_KEY"))

	location, _ := geocoder.Geocode(addr)
	if location != nil {
		lat := location.Lat
		long := location.Lng
		return float32(lat), float32(long)
	} else {
		fmt.Println("got <nil> location")
		return 0.0, 0.0
	}
}
