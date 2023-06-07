package main

import (
	"bytes"
	"database/sql"
	"mime/multipart"
	"net/http"
	"os"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
	uuid "github.com/satori/go.uuid"
)

type places struct {
	Place     string    `db:"place" json:"place"`
	Longitude float32   `db:"longitude" json:"longitude"`
	Latitude  float32   `db:"latitude" json:"latitude"`
	Photo     string    `db:"photo" json:"photo"`
	Visited   bool      `db:"visited" json:"visited"`
	UUID      uuid.UUID `db:"uuid" json:"uuid"`
}

func (p *places) getInfoVisited(db *sql.DB) (string, bool, error) {
	row := db.QueryRow("SELECT visited, photo FROM places_list WHERE place=$1", p.Place)

	var photo string
	var visited bool

	if err := row.Scan(&visited, &photo); err != nil {
		return "", false, err
	}

	return photo, visited, nil
}

func getVisited(db *sql.DB) ([]places, error) {
	rows, err := db.Query("SELECT * FROM places_list WHERE visited=true")

	if err != nil {
		return nil, err
	}

	defer rows.Close()

	places_list := []places{}

	for rows.Next() {
		var p places
		if err := rows.Scan(&p.UUID, &p.Place, &p.Longitude, &p.Latitude, &p.Photo, &p.Visited); err != nil {
			return nil, err
		}
		places_list = append(places_list, p)
	}

	return places_list, nil
}

func getToGo(db *sql.DB) ([]places, error) {
	rows, err := db.Query("SELECT * FROM places_list WHERE visited=false")

	if err != nil {
		return nil, err
	}

	defer rows.Close()

	places_list := []places{}

	for rows.Next() {
		var p places
		if err := rows.Scan(&p.UUID, &p.Place, &p.Longitude, &p.Latitude, &p.Photo, &p.Visited); err != nil {
			return nil, err
		}
		places_list = append(places_list, p)
	}

	return places_list, nil
}

func (p *places) deletePlace(db *sql.DB) error {
	_, err := db.Exec("DELETE FROM places_list WHERE place=$1", p.Place)

	return err
}

func deleteFileInS3(s *session.Session, filename string) (string, error) {

	bucket := os.Getenv("SPACES_BUCKET")

	_, err := s3.New(s).DeleteObject(&s3.DeleteObjectInput{
		Bucket: aws.String(bucket),
		Key:    aws.String(filename),
	})

	if err != nil {
		return "", err
	}

	return filename, err
}

func (p *places) addToGo(db *sql.DB, lat, long float32) error {
	uuid := uuid.NewV4()

	_, err := db.Exec(
		"INSERT INTO places_list VALUES($1, $2, $3, $4, $5, $6) RETURNING *",
		uuid, p.Place, lat, long, "NULL", false)

	if err != nil {
		return err
	}

	return db.QueryRow("SELECT * FROM places_list WHERE uuid=$1", uuid).
		Scan(&p.UUID, &p.Place, &p.Longitude, &p.Latitude, &p.Photo, &p.Visited)
}

func (p *places) addVisited(db *sql.DB, lat, long float32, photo string) error {
	uuid := uuid.NewV4()

	_, err := db.Exec(
		"INSERT INTO places_list VALUES($1, $2, $3, $4, $5, $6) RETURNING *",
		uuid, p.Place, lat, long, photo, true)

	if err != nil {
		return err
	}

	return db.QueryRow("SELECT * FROM places_list WHERE uuid=$1", uuid).
		Scan(&p.UUID, &p.Place, &p.Longitude, &p.Latitude, &p.Photo, &p.Visited)
}

func uploadFileToS3(s *session.Session, file multipart.File, fileHeader *multipart.FileHeader) (string, error) {

	bucket := os.Getenv("SPACES_BUCKET")

	size := fileHeader.Size
	buffer := make([]byte, size)
	file.Read(buffer)
	file.Seek(0, 0)

	_, err := s3.New(s).PutObject(&s3.PutObjectInput{
		Bucket:               aws.String(bucket),
		Key:                  aws.String(fileHeader.Filename),
		ACL:                  aws.String("public-read"),
		Body:                 bytes.NewReader(buffer),
		ContentLength:        aws.Int64(int64(size)),
		ContentType:          aws.String(http.DetectContentType(buffer)),
		ContentDisposition:   aws.String("attachment"),
		ServerSideEncryption: aws.String("AES256"),
	})
	if err != nil {
		return "", err
	}

	return fileHeader.Filename, err
}
