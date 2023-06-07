package main

import (
	"encoding/json"

	"net/http"
)

type VersionResponse struct {
	Version string `json:"version"`
}

type HealthResponse struct {
	Status int `json:"status"`
}

func Version(w http.ResponseWriter, r *http.Request) {
	response := VersionResponse{
		Version: version,
	}

	_, err := json.MarshalIndent(&response, "", " ")
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, err.Error())
		return
	}

	respondWithJSON(w, http.StatusOK, response)
}

func Health(w http.ResponseWriter, r *http.Request) {
	response := HealthResponse{
		Status: http.StatusOK,
	}

	_, err := json.MarshalIndent(&response, "", " ")
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, err.Error())
		return
	}

	respondWithJSON(w, http.StatusOK, response)
}
