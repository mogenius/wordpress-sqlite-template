# Credits: https://github.com/milanboers/wordpress-sqlite
FROM wordpress:fpm-alpine

# Pm ondemand to save RAM
RUN sed -i 's/pm = dynamic/pm = ondemand/g' /usr/local/etc/php-fpm.d/www.conf

RUN apk add --update curl unzip && rm -Rf /var/cache/apk/*

# Sqlite integration plugin
RUN curl -L https://github.com/aaemnnosttv/wp-sqlite-db/archive/refs/tags/v1.1.0.zip --output /tmp/wpplugin.zip 
RUN unzip /tmp/wpplugin.zip -d /usr/src/wordpress/wp-content/plugins/
RUN rm /tmp/wpplugin.zip
# Setup
RUN cp /usr/src/wordpress/wp-content/plugins/wp-sqlite-db-1.1.0/src/db.php /usr/src/wordpress/wp-content

COPY config/wp-config.php /var/www/wp-config.php
RUN chown www-data:www-data /var/www/wp-config.php

VOLUME ["/var/www/db"]
