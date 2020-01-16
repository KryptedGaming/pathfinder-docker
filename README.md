Dockerfile for running [Pathfinder](https://github.com/exodus4d/pathfinder), the mapping tool for EVE Online.

# Installation
1. Clone `docker-compose.yml` file (`wget https://raw.githubusercontent.com/KryptedGaming/pathfinder-docker/master/docker-compose.yml`)
2. Clone the example `.env` file (`wget https://raw.githubusercontent.com/KryptedGaming/pathfinder-docker/master/.env`)
3. Fill out the `.env` file and start up your instance with `docker-compose up -d`
4. You may need to create the databases for your MYSQL image if using a fresh compose. `sudo docker-compose exec db sh -c exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE pathfinder";` && `sudo docker-compose exec db sh -c exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE eve_universe";`

# Setup
1. Navigate to your Pathfinder page, go through setup.
2. Create the databases using the database controls in the setup page.
3. [Import static database.](#Importing-static-database)
4. Import from ESI at the Cronjob section of the setup page.
5. Build Systems data index under `Build search index` in the Administration section of the setup page.
5. Restart your container with `SETUP=False`.
6. You're live!

# Importing static database
1. `wget https://github.com/exodus4d/pathfinder/raw/master/export/sql/eve_universe.sql.zip`
2. `unzip eve_universe.sql.zip`
3. `docker cp eve_universe.sql "$(sudo docker-compose ps | grep db | awk '{ print $1}'):/eve_universe.sql"`
4. `sudo docker-compose exec db sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD" eve_universe < /eve_universe.sql'`
5. **Optional** `rm eve_universe.sql*`
6. [Complete Setup.](#Setup)

Feel free to contribute, there are many improvements that still need to be made.
