FROM kwoldt/mininit:stable-reduced
LABEL maintainer="bug@230woldt.de"

RUN /usr/local/bin/img_build.py --policyrcd forbid \
 && apt-get update \
 && apt-get install -y php-fpm \
 && /usr/local/bin/img_build.py --cleanup --reduce-size --policyrcd allow \
 # configure php \
 # TODO: logging \
 # TODO: health check
 && mkdir -p /run/php \
 && sed -e 's#;error_log = .*#error_log = /dev/stderr#' \
        -i /etc/php/*/fpm/php.ini \
 && sed -e 's#error_log = .*#error_log = /dev/stderr#' \
        -e 's/;daemonize = yes/daemonize = no/' \
        -i /etc/php/*/fpm/php-fpm.conf \
 && sed -e 's/^listen = .*/listen = 127.0.0.1:9000/' \
        -e 's/^;listen.allowed_clients/listen.allowed_clients/' \
	-e 's/^;ping.path/ping.path/' \
	-e 's#^;access.log.*#access.log = /dev/stdout#' \
        -e 's/^;catch_workers_output.*/catch_workers_output = yes/' \
        -i /etc/php/*/fpm/pool.d/www.conf

EXPOSE 9000
CMD ["/usr/sbin/php-fpm7.0", "--nodaemonize", "--fpm-config", "/etc/php/7.0/fpm/php-fpm.conf"]
