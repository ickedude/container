FROM kwoldt/mininit:stable-reduced
LABEL maintainer="bug@230woldt.de"

RUN /usr/local/bin/img_build.py --policyrcd forbid \
 && apt-get update \
 && apt-get install -y nginx-full \
 && /usr/local/bin/img_build.py --cleanup --reduce-size --policyrcd allow \
 && ln -sf /dev/stderr /var/log/nginx/error.log \
 && ln -sf /dev/stdout /var/log/nginx/access.log \
 # hide nginx version
 && sed -e 's/# server_tokens off;/server_tokens off;/' \
        -i /etc/nginx/nginx.conf

EXPOSE 80
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
