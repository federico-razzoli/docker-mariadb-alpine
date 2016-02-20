# MariaDB on Alpine Linux
FROM alpine:3.3
MAINTAINER Federico Razzoli "federico_raz@yahoo.it"

# MariaDB server and client
RUN apk update && apk add mariadb mariadb-client
# following tasks are not executed by mariadb package
RUN mkdir /run/mysqld
RUN chown mysql /run/mysqld
RUN chgrp mysql /run/mysqld
RUN mysql_install_db --user=mysql

# make life easier
ENV TERM xterm

# import files into container
COPY mariadb_conf/* /etc/mysql/

# MariaDB port
EXPOSE 3306
# Galera ports
# EXPOSE 4567 4568 4444

# demonize
ENTRYPOINT ["mysqld_safe"]

# last optimizations are done against the running daemon via SQL
#RUN until [ -f /var/run/mysqld/mysqld.sock ]; do sleep 1; done && mysql -e "DELETE FROM mysql.user WHERE user NOT LIKE 'root' OR host LIKE 'localhost';"

# metadata
LABEL   com.federico-razzoli.copyright="Federico Razzoli" \
	com.federico-razzoli.license="GNU AGPL 3.0" \
	com.federico-razzoli.maturity="stable"


