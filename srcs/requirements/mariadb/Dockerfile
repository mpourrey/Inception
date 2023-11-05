FROM        debian:bullseye

RUN			apt update && apt upgrade && apt-get install -y	\
                mariadb-server \
                mariadb-client

COPY        conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY        tools/script_mysql.sh /etc/mysql/script_mysql.sh
CMD         ["/bin/bash", "/etc/mysql/script_mysql.sh"]
           