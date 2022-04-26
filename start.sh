#!/bin/zsh
service php8.1-fpm start && service nginx start && tail -f /dev/stdout
