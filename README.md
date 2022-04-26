## 版本

* Basic Image: Ubuntu:20.04

* Nginx: `1.18.0`
* PHP: `8.1.5`
* Composer: `2.3.5`
* Oh-My-Zsh
* PHP-fpm + Nginx: unix socket

## 快速使用

```shell
docker run -d --rm --name php-server -p 80:80 mrnicolascoge/php-server
```

## 拷贝配置

```shell
# nginx
docker cp php-server:/etc/nginx /path/your-config/nginx
# php
docker cp php-server:/etc/php/8.1/fpm /path/your-config/php
```

## 停止容器

```shell
docker stop php-server
```

## 项目目录

挂载配置启动容器

```shell
docker run -d --rm -p 80:80 --name php-server
-v /path/your-project:/var/www/html 
# 自定义 Nginx 配置
-v /path/your-config/nginx:/etc/nginx
# 自定义 PHP 配置
-v /path/your-config/php:/etc/php/8.1/fpm
# log 文件
-v /path/your-logs/nginx:/var/log/nginx
mrnicolascoge/php-server
```

## 使用命令

```shell
docker exec -it php-server php -v
docker exec -it php-server composer -V
```


