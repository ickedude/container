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
 && sed -e 's/^;catch_workers_output.*/catch_workers_output = yes/' \
        -i /etc/php/*/fpm/pool.d/www.conf

VOLUME ["/var/run/php"]
CMD ["/usr/sbin/php-fpm7.0", "--nodaemonize", "--fpm-config", "/etc/php/7.0/fpm/php-fpm.conf"]
