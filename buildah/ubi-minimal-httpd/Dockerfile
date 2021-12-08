FROM registry.access.redhat.com/ubi8/ubi-minimal
RUN microdnf install -y httpd
COPY ./index.html /var/www/html

EXPOSE 80

ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]
