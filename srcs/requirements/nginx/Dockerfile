
FROM		debian:bullseye

#openssl : bibliotheque d'algo de chiffrement, pour implementer des protocoles de securite
RUN			apt update && apt upgrade && apt install -y	\
				nginx \
				openssl 
				
# req : creation de certificat autosigne (sans autorite de certification)
# -x509 : norme de cerificat
# -nodes : ne pas proteger la cle privee avec mdp (pour dechiffrage de la cle de session)
# -out -keyout : emplacements
# -subj : remplir automatiquement infos du certificat
RUN			mkdir -p /etc/nginx/ssl
RUN			openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=mpourrey.42.fr/UID=mpourrey"

RUN 		chown --recursive www-data:www-data /var/www/html

# supprime le fichier conf existant et le remplace par le notre
RUN			rm -f /etc/nginx/nginx.conf
COPY		conf/nginx.conf /etc/nginx/nginx.conf

# commande a executer au demarrage du conteneur : executable nginx
# avec l' option (-g) deamon off = fonctionner en premier plan + afficher des journaux dans la console du conteneur
CMD     ["nginx", "-g", "daemon off;"]