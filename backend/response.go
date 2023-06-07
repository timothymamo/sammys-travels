package main

import (
	"encoding/json"
	"net/http"
)

func respondWithError(w http.ResponseWriter, code int, message string) {
	respondWithJSON(w, code, map[string]string{"error": message})
}

func respondWithJSON(w http.ResponseWriter, code int, payload interface{}) {
	response, _ := json.Marshal(payload)

	if code != 200 {
		w.WriteHeader(code)
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(response)
}
