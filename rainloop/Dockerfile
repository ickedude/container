ARG CODE_VERSION="0.1.0"
ARG RAINLOOP_VERSION=1.12.0
ARG MAINTAINER="bug@230woldt.de"
ARG DOC_ROOT=/var/www/rainloop

FROM kwoldt/nginx:${CODE_VERSION}
ARG MAINTAINER
ARG DOC_ROOT
LABEL maintainer=${MAINTAINER}
COPY resources/statics /
RUN chown -R www-data:www-data ${DOC_ROOT} \
 && find ${DOC_ROOT} -type d -exec chmod 750 {} \; \
 && find ${DOC_ROOT} -type f -exec chmod 640 {} \;


FROM kwoldt/php-fpm:${CODE_VERSION}
ARG MAINTAINER
ARG DOC_ROOT
LABEL maintainer=${MAINTAINER}
COPY resources/webapp /
RUN /usr/local/bin/img_build.py --policyrcd forbid \
 && apt-get update \
 && apt-get install -y php-curl php-xml \
 && /usr/local/bin/img_build.py --cleanup --reduce-size --policyrcd allow
RUN chown -R www-data:www-data ${DOC_ROOT} \
 && find ${DOC_ROOT} -type d -exec chmod 750 {} \; \
 && find ${DOC_ROOT} -type f -exec chmod 640 {} \;
