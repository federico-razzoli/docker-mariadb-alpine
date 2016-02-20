# MariaDB on Alpine Linux
FROM alpine:3.3
MAINTAINER Federico Razzoli "federico_raz@yahoo.it"

# MariaDB server and client
RUN apk update && apk add mariadb mariadb-client
# this is not executed by mariadb package
RUN mysql_install_db --user=mysql

# make life easier
ENV TERM xterm
# less platform-dependent
ENV MARIADB_DATA_PATH /var/lib/mysql
ENV MARIADB_LOGS_PATH /var/log/mysql

# import files into container
COPY mariadb_conf/* /etc/mysql/

# last optimizations are done against the running daemon via SQL
#RUN mysqld && until [ -e /var/run/mysqld/mysqld.sock ]; do sleep 1; done && mysql -e "DELETE FROM mysql.user WHERE user NOT LIKE 'root' OR host LIKE 'localhost';"

# other applications need to backup/analyze data and logs
VOLUME MARIADB_DATA_PATH
VOLUME MARIADB_LOGS_PATH

# demonize
ENTRYPOINT ["mysqld_safe"]

# MariaDB port
EXPOSE 3306
# Galera ports
# EXPOSE 4567 4568 4444

# metadata
LABEL   com.federico-razzoli.copyright="Federico Razzoli" \
	com.federico-razzoli.license="GNU AGPL 3.0" \
	com.federico-razzoli.maturity="stable"


