### TELECHARGEMENT DU SERVICE WORDPRESS
# telecharge le fichier wordpress (= l'application wordpress)
wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www/html

#decompresse le fichier telecharge : recuperation du dossier wordpress
cd /var/www/html && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.t
chown --recursive www-data:www-data /var/www/*

# installation de l'interface en ligne de commande de wordpress 
#	+ lui donner droit d'execution + deplacement
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp


### CONFIGURATION DE LA DB MARIADB AVEC WORDPRESS
if [ ! -f /data/www/wp-config.php ]
then
	# attendre que la base de donnees mariadb soit bien installee
	sleep 10

	# cree un nouveau fichier wp-config.php = un fichier de conf 
	#		 qui correspond a une bd deja existante
	cd /var/www/html/wordpress
	wp core config	--allow-root \
					--dbname="$SQL_DATABASE" \
					--dbuser="$SQL_USER" \
					--dbpass="$SQL_PASSWORD" \
					--dbhost='mariadb:3306' #la db se situe dans le service mariadb, acces depuis port 3306

	# installe le site wordpress avec un admin
	wp core install     --allow-root \
				        --url="$DOMAIN_NAME" \
				        --title="Wah le joli site" \
				        --admin_user="$WP_ADMIN" \
				        --admin_password="$WP_ADMIN_PASSWORD" \
				        --admin_email="$WP_ADMIN@$DOMAIN_NAME" --skip-email

	# cree un autre user dans wordpress
	wp user create      $WP_USER $WP_USER@$DOMAIN_NAME \
						--allow-root \
				        --role=author \
				        --user_pass="$WP_USER_PASSWORD"
	fi

#LANCEMENT DE PHP-FPM
#fichier de stockage de php7.4-fpm.pid = processus principal de php-fpm
if [ ! -d /run/php ]; then
mkdir /run/php;
fi

# start PHP FastCGI Process Manager (FPM) au premier plan (foreground)
exec /usr/sbin/php-fpm7.4 -F