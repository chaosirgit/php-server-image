## 构建文件
构建文件代码仓库点击[这里查看](https://github.com/chaosirgit/php-server-image)
## 版本

* Basic Image: Ubuntu:20.04

* Nginx: `1.18.0`
* PHP: `8.1.5`
* Composer: `2.3.5`
* Oh-My-Zsh
* PHP-fpm + Nginx: unix socket

## 快速使用
单独使用命令

```shell
docker run --rm mrnicolascoge/php-server "php -v"
docker run --rm mrnicolascoge/php-server "composer -V"
docker run --rm -it -v $PWD:/root mrnicolascoge/php-server "composer install"
docker run --rm -it -v $PWD:/root mrnicolascoge/php-server "php artisan"
```
开启 nginx
```shell
docker run -itd --rm --name php-server -p 80:80 mrnicolascoge/php-server
```
查看 phpinfo 输入 http://localhost 即可

查看 nginx log
```shell
docker logs php-server
```

## 拷贝配置

```shell
# nginx
docker cp php-server:/etc/nginx/sites-enabled /path/your-config/nginx/vhost
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
docker run -d -p 80:80 --name php-server --restart=always \
# 项目
-v /path/your-project:/var/www/html \
# 自定义 Nginx 配置 \
-v /path/your-config/nginxi/vhost:/etc/nginx/sites-enabled
# 自定义 PHP 配置
-v /path/your-config/php:/etc/php/8.1/fpm
mrnicolascoge/php-server
```

重启服务
```shell
docker restart php-server 
```
