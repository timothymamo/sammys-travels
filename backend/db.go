package main

import (
	"database/sql"
	"fmt"
	"log"
	"time"

	_ "github.com/lib/pq"
)

func DbInitialize(host, user, password, dbname, schema string, port int) (*sql.DB, error) {

	var connectionString string

	dbsslmode := GetEnv("DB_SSL_MODE", "require")

	connectionString =
		fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s search_path=%s sslmode=%s", host, port, user, password, dbname, schema, dbsslmode)

	db, err := sql.Open("postgres", connectionString)
	if err != nil {
		return nil, err
	}

	retryCount := 5
	for {
		err := db.Ping()
		if err != nil {
			if retryCount == 0 {
				log.Fatalf("Could not establish connection to database: %s", err.Error())
			}

			log.Printf("Could not connect to database. Waiting 2 seconds. %d retries left...", retryCount)
			retryCount--
			time.Sleep(2 * time.Second)
		} else {
			break
		}
	}

	return db, nil
}
