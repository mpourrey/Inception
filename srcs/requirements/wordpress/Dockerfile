FROM        debian:bullseye

RUN         apt update && apt upgrade && apt-get install -y	\
				wget \
                php7.4 \
                php-fpm \
				php7.4-mysql \
				mariadb-client

# fichier de conf de php-fpm
COPY		conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY        tools/script_wordpress_php.sh /etc/wordpress/script_wordpress_php.sh

CMD        ["/bin/bash", "/etc/wordpress/script_wordpress_php.sh"] 
