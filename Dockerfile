FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN adduser --disabled-password --gecos '' pathfinder 



# INSTALL PACKAGES
RUN apt-get update --fix-missing && \
	apt-get install -y software-properties-common && \
	LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && \ 
	apt-get update && \
	apt-get update --fix-missing

RUN apt-get install -y \ 
	sudo \
	php7.2 \
	php7.2-gd \ 
	php7.2-xml \ 
	php7.2-fpm \ 
	php7.2-mysql \ 
	php7.2-mbstring \ 
	php7.2-curl \ 
	php7.2-redis \
	php7.2-dev \
	gzip \ 
	wget \
	nginx \ 
	zip \ 
	git \ 
	redis-server \
	curl \
	cron 

# ADD NODE
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
RUN apt-get install -y \ 
	nodejs

# COPY PATHFINDER
ARG VERSION 
RUN mkdir /var/www/pathfinder
RUN mkdir /var/log/cron-www/
RUN git clone --branch master https://github.com/exodus4d/pathfinder.git /var/www/pathfinder
COPY ./config/composer.json /root/.composer/config.json
RUN chown -R www-data:www-data /var/www/pathfinder
RUN mkdir /tmp/cache/
RUN mkdir /var/www/pathfinder/conf/
RUN chmod -R 766 /tmp/cache/ /var/www/pathfinder/logs/

# COMPOSER INSTALL
RUN curl -sS https://getcomposer.org/installer | php -- --version=1.8.6
RUN mv composer.phar /usr/local/bin/composer
RUN composer install -d /var/www/pathfinder/

# COPY PATHFINDER Websocket Server
RUN mkdir /var/www/pathfinder_websocket
RUN git clone https://github.com/exodus4d/pathfinder_websocket.git /var/www/pathfinder_websocket
RUN chown -R www-data:www-data /var/www/pathfinder_websocket

# COPY PATHFINDER Websocket Server service script
COPY ./config/pathfinder-websocket /etc/init.d/
RUN chmod +x /etc/init.d/pathfinder-websocket

# COMPOSER INSTALL Pathfinder Websocket server
RUN composer install -d /var/www/pathfinder_websocket/

# CONFIGURE NGINX
COPY ./config/default /etc/nginx/sites-available/
COPY ./config/www.conf /etc/php/7.2/fpm/pool.d/

# CONFIGURE REDIS
COPY ./config/redis.conf /etc/redis/
RUN chmod 755 /etc/redis/redis.conf

# CONFIGURE PHP7.2-FPM
COPY ./config/php.ini /etc/php/7.2/fpm/

# SET UP CRONJOB
COPY ./config/default_crontab /home/
RUN crontab /home/default_crontab

# COPY ENTRYPOINT
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh 

ENTRYPOINT ["entrypoint.sh"]


