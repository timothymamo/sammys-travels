package main

import (
	"encoding/json"
	"net/http"

	log "github.com/sirupsen/logrus"
)

func respondWithError(w http.ResponseWriter, code int, message string) {
	log.SetFormatter(&log.JSONFormatter{})

	respondWithJSON(w, code, map[string]string{"error": message})
	log.Error(map[string]string{"error": message})
}

func respondWithJSON(w http.ResponseWriter, code int, payload interface{}) {
	log.SetFormatter(&log.JSONFormatter{})
	response, _ := json.Marshal(payload)

	if code != 200 {
		w.WriteHeader(code)
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(response)
}
