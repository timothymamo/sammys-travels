# Local Development

The application can be run locally by running a `docker compose up -d` command from the [local folder](./local/). This will build the `frontend`, `backend` and `db_migrate` containers from source as well as deploy a PostgreSQL database container and a [localstack](https://localstack.cloud/) container to simulate the bucket. Once the containers are up and running point your browser to [http://localhost](http://localhost) to access the application.

The only differences between the `docker-compose.yml` file used for local development and that used in production are disabling `sslmode` in the `db_migrate` container and the following environment variables used in the backend container:

```bash
  backend:
    ...
    environment: # Only needed for local development
      - DB_SSL_MODE=disable # SSL connection to the database disabled for local development
      - FORCE_PATH_STYLE=true # Forces bucket path to adhere to the following format http://localhost:4572/{bucket_name}
```