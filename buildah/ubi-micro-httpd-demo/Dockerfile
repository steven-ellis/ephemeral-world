FROM ubi-micro-httpd 

COPY ./index.html /var/www/html
EXPOSE 80

ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]
