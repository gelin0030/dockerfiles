pull:
	docker pull nginx:1.9.0
	docker pull php:5.6-fpm
	docker pull mysql:5.6
	docker pull redis:3.0
	docker pull memcached:1.4
	docker pull node:0.12

init:
	wget https://github.com/phalcon/cphalcon/archive/1.3.5.tar.gz -O php/cphalcon.tgz
	wget https://pecl.php.net/get/gearman-1.1.2.tgz -O php/gearman.tgz
	wget https://pecl.php.net/get/redis-2.2.7.tgz -O php/redis.tgz
	wget https://pecl.php.net/get/memcached-2.2.0.tgz -O php/memcached.tgz
	wget https://pecl.php.net/get/xdebug-2.3.2.tgz -O php/xdebug.tgz
	wget https://pecl.php.net/get/msgpack-0.5.6.tgz -O php/msgpack.tgz
	wget https://pecl.php.net/get/memcache-2.2.7.tgz -O php/memcache.tgz
	wget https://pecl.php.net/get/xhprof-0.9.4.tgz -O php/xhprof.tgz
	wget https://getcomposer.org/composer.phar -O php/composer.phar
	mkdir ~/opt ~/opt/run ~/opt/data ~/opt/data/mysql ~/opt/data/elasticsearch ~/opt/log ~/opt/log/nginx ~/opt/log/php ~/opt/log/mysql ~/opt/htdocs ~/opt/www
	
build:
	make build-nginx
	make build-mysql
	make build-php
	make build-node
	
build-nginx:
	docker build -t env/nginx ./nginx

run-nginx:
	docker run -i -d -p 80:80 -v ~/opt:/opt -t env/nginx

in-nginx:
	docker run -i -p 80:80 -v ~/opt:/opt -t env/nginx /bin/bash

build-php:
	docker build -t env/php ./php

run-php:
	docker run -i -d -p 9000:9000 -v ~/opt:/opt -t env/php

in-php:
	docker run -i -p 9000:9000 -v ~/opt:/opt -t env/php /bin/bash

build-mysql:
	docker build -t env/mysql ./mysql

run-mysql:
	docker run -i -d -p 3306:3306 -v ~/opt/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -t env/mysql

in-mysql:
	docker run -i -p 3306:3306  -v ~/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -t env/mysql /bin/bash

build-node:
	docker build -t env/node ./node

run-node:
	docker run -i -d -p 8001:8001 -v ~/opt:/opt -t env/node

in-node:
	docker run -i -p 8001:8001 -v ~/opt:/opt -t env/node /bin/bash

build-elasticsearch:
	docker build -t env/elasticsearch ./elasticsearch

run-elasticsearch:
	docker run -i -d -p 9200:9200 -p 9300:9300 -v ~/opt/data/elasticsearch:/usr/share/elasticsearch/data -t env/elasticsearch

in-elasticsearch:
	docker run -i -p 9200:9200 -p 9300:9300 -v ~/opt/data/elasticsearch:/usr/share/elasticsearch/data -t env/elasticsearch /bin/bash

build-gearman:
	docker build -t env/gearman ./gearman

run-gearman:
	docker run -d -p 4730:4730 -v ~/opt:/opt -it env/gearman

stop:
	docker ps -a | grep "Exited" | awk '{print $1 }'|xargs docker stop
	docker ps -a | grep "Exited" | awk '{print $1 }'|xargs docker rm

clean:
	docker images|grep none|awk '{print $3 }'|xargs docker rmi
