package main

import (
	"database/sql"

	"github.com/go-chi/chi/v5"
)

type App struct {
	Router   chi.Router
	Database *sql.DB
}

func (app *App) initializeRoutes() {

	app.Router.Get("/api/", app.Index)

	app.Router.Get("/api/health", Health)

	app.Router.Get("/api/version", Version)

	app.Router.Get("/api/visited", app.getVisited)

	app.Router.Get("/api/togo", app.getToGo)

	app.Router.Delete("/api/delete/{place}", app.deletePlace)

	app.Router.Post("/api/addtogo", app.addToGo)

	app.Router.Post("/api/addvisited", app.addVisited)

	app.Router.Post("/api/uploadphoto", uploadPhoto)
}
