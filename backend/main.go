package main

import (
	"log"
	"net/http"
	"os"
	"strconv"

	"github.com/go-chi/chi/v5"
)

const (
	version = "v0.3.3"
)

func main() {
	port, _ := strconv.Atoi(os.Getenv("POSTGRES_PORT"))

	database, err := DbInitialize(
		os.Getenv("POSTGRES_HOST"),
		os.Getenv("POSTGRES_USERNAME"),
		os.Getenv("POSTGRES_PASSWORD"),
		os.Getenv("POSTGRES_DB"),
		os.Getenv("POSTGRES_SCHEMA"),
		port)

	if err != nil {
		log.Fatalf("Database connection failed: %s", err.Error())
	}

	app := App{
		Router:   chi.NewRouter(),
		Database: database,
	}

	app.initializeRoutes()

	app.Run(":8000")
}

func enableCors(w *http.ResponseWriter) {
	(*w).Header().Set("Access-Control-Allow-Origin", "*")
}
