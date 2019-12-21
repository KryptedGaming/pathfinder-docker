FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN adduser --disabled-password --gecos '' pathfinder 

# INSTALL PACKAGES
RUN apt-get update && \
	apt-get install -y software-properties-common && \
	LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && \ 
	apt-get update && \
	apt-get update --fix-missing

RUN apt-get install -y \ 
	php7.2 \
	php7.2-gd \ 
	php7.2-xml \ 
	php7.2-fpm \ 
	php7.2-mysql \ 
	php7.2-mbstring \ 
	php7.2-curl \ 
	php7.2-redis \
	gzip \ 
	wget \
	nginx \ 
	zip \ 
	git \ 
	redis-server \
	curl 

# COPY PATHFINDER
ARG VERSION 
RUN mkdir /var/www/pathfinder
RUN git clone --branch $VERSION https://github.com/exodus4d/pathfinder.git /var/www/pathfinder
COPY ./config/composer.json /root/.composer/config.json
RUN chown -R www-data:www-data /var/www/pathfinder
RUN mkdir /tmp/cache/
RUN chmod -R 766 /tmp/cache/ /var/www/pathfinder/logs/
RUN mkdir /var/www/pathfinder/conf/
COPY ./config/pathfinder.ini /var/www/pathfinder/conf/

# COMPOSER INSTALL
RUN	curl --silent --show-error https://getcomposer.org/installer | php 
RUN mv composer.phar /usr/local/bin/composer
RUN composer install -d /var/www/pathfinder/

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

# CMD service php7.2-fpm start && service redis-server start && nginx -g "daemon off;"
