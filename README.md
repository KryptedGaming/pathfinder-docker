Dockerfile for running [Pathfinder](https://github.com/exodus4d/pathfinder), the mapping tool for EVE Online.

# Configuration
* Edit `config/default`, replace `localhost` with your server IP
* Edit `docker-compose.yml`, feel free to change `MYSQL_ROOT_PATHFINDER`
* Configure all files in `config/pathfinder` per standard pathfinder installation
* **Optional:** Uncomment and change any values in `config/pathfinder.ini` for overwriting values in the default pathfinder.ini file
* Update your host nginx configuration (or apache) to ProxyPass your port (e.g 8000) 

# Setup
* Unzip the eve_universe.sql file. (`cd config`), (`unzip eve_universe.sql.zip`)
* Start Pathfinder container (`./launcher start`)
* Go to domain.com/map and run through setup
* Enter the database container (`docker exec -it {name} /bin/bash`)
* Import the SQL export (`mysql -u root -p eve_universe < /docker-entrypoint-initdb.d/dump.sql`)

Feel free to contribute, there are many improvements that still need to be made.
