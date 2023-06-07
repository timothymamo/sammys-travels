# Application

This directory holds the logic and Dockerfile for the api, as well as the SQL scripts and Dockerfile for the migration container.

### Requirements

-   [golang](https://golang.org/doc/install)
-   [docker](https://docs.docker.com/engine/install/)

## DB Migration

The [db directory](./db) holds the SQL migration scripts and CSV file, with the data provided, as well as a small Dockerfile that uses the [migrate/migrate](https://hub.docker.com/r/migrate/migrate) container as the base image with the files within the [migrations dir](./db/migrations) copied.

Each SQL migration script consists of an `up.sql` and its equivalent `down.sql` scripts. The initial script sets up the `passenger_list` table with the appropriate columns, and the second script copies the csv data to the database.

To run the container locally you will need to first create a postgres container. Execute the following commands, within the application directory, to get you up and running.

```bash
cd ./db

docker build -t db-migrate .

docker run -d --name psql-db \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=postgres \
  -v "migrations:/data" \
  -p 5432:5432 \
  postgres:13.1

docker run -d --name db-migrate \
  -v "migrations:/migrations" \
  --network host \
  db-migrate:latest \
  -path=/migrations/ \
  -database "postgres://postgres:password@localhost:5432/postgres?sslmode=disable&search_path=public" \
  up
```

Once the db-migrate container is running you will be able to access the postgres database and look at the data within using your favorite database manager (for example [DBeaver](https://dbeaver.io/)).

## API

The application is written in Golang, and is divided into the following files:

-   [main.go](main.go) - Main function that starts the api and gets environment variables to be used by the application.
-   [db.go](db.go) - Function initializing, and checks, the connection to the postgres database.
-   [info.go](info.go) - Sets up api information (version) and health checks.
-   [app.go](app.go) - Function that runs the server as well as ensures a graceful shutdown occurs when a SIGINT or SIGTERM signal is received.
-   [handlers.go](handlers.go) - Functions that set up the api handlers.
-   [models.go](models.go) - Functions that perform the sql commands to generate the requested response.
-   [router.go](router.go) - Initializes the routes of the api.
-   [response.go](response.go) - Functions used to generate Error, Json and HTML responses.

To run the code ensure that the `db-psql` and `db-migrate` containers are running as specified [above](#migration). Once the containers are running execute the following commands, within the application directory:

```bash
# Within the shell you are going to run the code
export POSTGRES_HOST=localhost
export POSTGRES_USERNAME=postgres
export POSTGRES_PASSWORD=password
export POSTGRES_DB=postgres
export POSTGRES_PORT=5432
export POSTGRES_SCHEMA=public

# You might get an error when first running this command regarding go modules that need to downloaded.
# Follow the instructions (usually `go mod download`) and rerun.
go run .
```

You can then access the api at [http://localhost:8000](http://localhost:8000)
API endpoints documentation which have been implemented can be found [here](API.md).

## Application Dockerfile

The application [Dockerfile](Dockerfile) is extremely small when created (< 10MB). This is due to the fact that the container is built using a multi-stage process as well as golang's binary build process.

## Possible Improvements

Addition improvements to the api code could be:

-   Set of tests that could be run automatically at every code commit (via a pre-commit hooks configuration) or push (via a CI/CD pipeline).
-   Authentication and validation process to the api.
