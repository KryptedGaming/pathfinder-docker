Dockerfile for running [Pathfinder](https://github.com/exodus4d/pathfinder), the mapping tool for EVE Online.

# Installation
1. Clone `docker-compose.yml` file (`wget https://raw.githubusercontent.com/KryptedGaming/pathfinder-docker/master/docker-compose.yml`)
2. Clone the example `.env` file (`wget https://raw.githubusercontent.com/KryptedGaming/pathfinder-docker/master/.env`)
3. Fill out the `.env` file and start up your instance with `docker-compose up -d`

# Setup
1. Navigate to your Pathfinder page, go through setup.
2. Create the databases using the database controls in the setup page.
3. [Import static databse.](#Importing-static-databse)
4. Import from ESI at the Cronjob section of the setup page.
5. Build Systems data index under `Build search index` in the Administration section of the setup page.
5. Restart your container with `SETUP=False`.
6. You're live!

# Importing staic database
1. Download the static database.
2. Unzip `eve_universe.sql.zip`.
3. Copy the databse into the db container `docker cp eve_universe.sql {full container name: eg. pathfinder-docker_db_1}:/eve_universe.sql`.
4. Enter the db container `docer-compose exec db /bin/bash`.
5. Make sure you have completed step 2 in Setup.
6. Link static databse `mysql -u root -p eve_universe< eve_universe.sql`.
7. Enter the password listed in `.env`.
8. Exit the db container `exit`.
9. [Complete Setup.](#Setup)

Feel free to contribute, there are many improvements that still need to be made.
