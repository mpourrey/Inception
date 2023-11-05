echo "...Creation du repertoire /run/mysqld et cession des droits sur le repertoire au groupe mysql"
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

echo "...Tentative de demarrage du serveur MYSQL" 
mysqld &
while !(mysqladmin ping > /dev/null)
do
    sleep 5
done

echo "...Creation de la base de donnees $SQL_DATABASE"
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
echo "...Creation du user $SQL_USER avec mot de passe"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
echo "...Cession des droits sur la base de donnees au user $SQL_USER"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
echo "...Modification du mot de passe du user root"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
echo "...Actualisation des droits dans le serveur MySQL"
mysql -uroot -p$SQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
echo "...Extinction du serveur MYSQL"
mysqladmin -uroot -p$SQL_ROOT_PASSWORD shutdow
echo "...Redemarrage du serveur MYSQL en mode safe"
exec mysqld_safe

