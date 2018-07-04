FROM kwoldt/mininit:stable-reduced
LABEL maintainer="bug@230woldt.de"

RUN /usr/local/bin/img_build.py --policyrcd forbid \
 && apt-get update \
 && apt-get install -y nginx-full \
 && /usr/local/bin/img_build.py --cleanup --reduce-size --policyrcd allow \
 && ln -sf /dev/stdout /var/log/nginx/error.log \
 && ln -sf /dev/stdout /var/log/nginx/access.log \
 # remove default config \
 # TODO: maybe use apt-get -o DPKG... path-exclude to prevent installing the files
 && rm -rf /etc/nginx/sites-enabled/default /var/www/html \
 # hide nginx version
 && sed -i "s/# server_tokens off;/server_tokens off;/g" /etc/nginx/nginx.conf

EXPOSE 80
# TODO: look into /etc/init.d/nginx
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
