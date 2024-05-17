FROM mysql
ENV MYSQL_ROOT_PASSWORD=toor
ENV MYSQL_DATABASE=accounts
ADD ./db_backup.sql /docker-entrypoint-initdb.d
EXPOSE 3306
