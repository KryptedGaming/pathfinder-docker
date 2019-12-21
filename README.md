Dockerfile for running [Pathfinder](https://github.com/exodus4d/pathfinder), the mapping tool for EVE Online.

# Installation
1. Clone `docker-compose.yml` file (`wget https://raw.githubusercontent.com/KryptedGaming/pathfinder-docker/master/docker-compose.yml`)
2. Clone the example `.env` file (`wget https://raw.githubusercontent.com/KryptedGaming/pathfinder-docker/master/.env`)
3. Fill out the `.env` file and start up your instance with `docker-compose up -d`

# Setup
1. Navigate to your Pathfinder page, go through setup.
2. Create the databases, import from ESI at the bottom.
3. Restart your container with `SETUP=False`
4. You're live!

Feel free to contribute, there are many improvements that still need to be made.
