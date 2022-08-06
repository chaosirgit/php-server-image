FROM ubuntu:20.04
MAINTAINER Ethan Kuo <mrnicolascoge@gmail.com>
WORKDIR /root
RUN apt update \
    && apt-get install -y git curl zsh zip \
    && echo Y|sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y tzdata \
    && apt-get install -y software-properties-common \
    && apt update \
    && add-apt-repository ppa:ondrej/php -y \
    && apt update \
    && apt-get install -y php8.1 php8.1-fpm php8.1-bcmath php8.1-curl php8.1-decimal php8.1-gd php8.1-mbstring php8.1-mcrypt php8.1-redis php8.1-swoole php8.1-opcache php8.1-xml php8.1-zip php8.1-pgsql \ 
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    && apt-get install -y nginx
RUN rm -f /var/www/html/index.html /var/www/html/index.nginx-debian.html \
    && rm -f /etc/nginx/sites-enabled/default \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && echo "listen.allowed_clients = 127.0.0.1\npm.max_children = 50\npm.start_servers = 5\npm.min_spare_servers = 5\npm.max_spare_servers = 10\nlisten.backlog = -1" >> /etc/php/8.1/fpm/pool.d/www.conf \
    && echo "[php]\nmemory_limit = 1024M" >> /etc/php/8.1/fpm/php.ini \
    && echo "<?php phpinfo();?>" > /var/www/html/index.php
COPY --chown=root:root ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --chown=root:root ./nginx/laravel-default.conf /etc/nginx/sites-enabled/laravel-default
COPY --chown=root:root ./start.sh /root/start.sh
CMD ["./start.sh"]
EXPOSE 80
