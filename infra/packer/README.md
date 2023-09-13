# Supabase on DigitalOcean - Packer

> _IMPORTANT:_ A note on secrets/tokens/apis. Ensure that any files containing secrets/tokens/apis are _NOT_ stored in version control.

The initial step to create a Snapshot, using Packer, and storing it on DigitalOcean is to input some variables within a `sammys-travels.auto.pkrvars.hcl` file. An [example](./sammys-travels.auto.pkrvars.hcl.example) file has been provided.

Then modify the image for the frontend (line 42), backend (line 27) and db_migrate (line 16) containers in teh [docker-compose.yml](./sammys_travels/docker-compose.yml) file to point to where you have stored.


```bash
## From the root of the repository change directory to the packer directory
cd packer

## Copy the example file to sammys-travels.auto.pkrvars.hcl, modify it with your own variables and save
cp sammys-travels.auto.pkrvars.hcl.example sammys-travels.auto.pkrvars.hcl
```

After creating the variables you can create the snapshot and upload it to DO by running the following commands:

```bash
## Initialise packer to download any plugin binaries needed
packer init .

## Build the snapshot and upload it as a Snapshot on DO
packer build .
```

## Packer file structure

**_What's happening in the background_**

A DigitalOcean Droplet is temporarily spun up to create the Snapshot. Within this Droplet, Packer copies the [supabase](./packer/supabase) directory that contains the following files:

 ```bash
 .
├── docker-compose.yml # Containers to run Supabase on a Droplet
├── supabase.subdomain.conf # Configuration file for the swag container (runs nginx)
└── volumes
    └── db # SQL files when initialising Supabase
        ├── realtime.sql
        └── roles.sql
 ```

and also runs the [setup script](./packer/scripts/setup.sh) that installs `docker`, `docker compose` and `incron` onto the image.

_N.B. If you changed the image to a non Ubuntu/Debian image the script will fail as it uses the `apt` package manager. Should you wish to use a different OS, modify the script with the appropriate package manager._

Your Snapshot name will be created and stored on DigitalOcean with the naming format `sammys-travels-yyyymmddhhmmss`. You'll be able to find this under `Images > Snapshots` in the DigitalOcean Cloud UI.

Now that we've created a snapshot with Docker and Docker Compose installed on it as well as the required `docker-compose.yml` and `conf` files, we will use Terraform to deploy all the resources required to have Sammy's Travels up and running on DigitalOcean.

* The next steps can be found in the [terraform directory](../terraform/).