# MariaDB on Alpine Linux
FROM alpine:3.3
MAINTAINER Federico Razzoli "federico_raz@yahoo.it"

# MariaDB server and client
RUN apk update && apk add mariadb mariadb-client
# this is not executed by mariadb package
RUN mysql_install_db --user=mysql

# make life easier
ENV TERM xterm

# import files into container
COPY mariadb_conf/* /etc/mysql/
#COPY scripts/* /opt/mysql/

# last optimizations are done against the running daemon via SQL
#RUN /opt/mysql/prepare-db

# other applications need to backup/analyze data and logs
VOLUME /var/lib/mysql
VOLUME /var/log/mysql

# create and make available a directory for backups
mkdir -p /var/backups/mysql
chmod a+r /var/backups/mysql/
VOLUME /var/backups/mysql

# demonize
ENTRYPOINT ["mysqld_safe"]

# MariaDB port
EXPOSE 3306
# Galera ports
# EXPOSE 4567 4568 4444

# metadata
LABEL   com.federico-razzoli.copyright="Federico Razzoli" \
	com.federico-razzoli.license="GNU AGPL 3.0" \
	com.federico-razzoli.maturity="beta"


