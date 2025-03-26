FROM nginx:latest
LABEL authors="jbadaire"
LABEL org.opencontainers.image.source=https://github.com/42-Transcendance-CGPSV/front_end
LABEL org.opencontainers.image.description="Nginx server for the front-end of the Transcendance project.\
Contains the front-end files and the nginx configuration.\
Designed to deliver the front-end files and to be used as a reverse proxy for the back-end."
LABEL org.opencontainers.image.licenses="GNU General Public License v3.0"


#Setup ssl files
COPY ./web_server/ft_transcendence.crt /etc/nginx/ssl/ft_transcendence.crt
COPY ./web_server/ft_transcendence.key /etc/nginx/ssl/ft_transcendence.key
COPY ./web_server/certificate_key.txt /etc/nginx/ssl/certificate_key.txt

# Secur ssl files
RUN chmod 600 /etc/nginx/ssl/* && \
    chown nginx:nginx /etc/nginx/ssl/certificate_key.txt

# creates nginx folders
RUN mkdir -p /var/cache/nginx /var/run/nginx /tmp/nginx_client_temp && \
    chown -R nginx:nginx /etc/nginx /var/cache/nginx /var/run/nginx /tmp/nginx_client_temp /var/log/nginx

#setup nginx config
COPY ./web_server/transcendence_nginx.conf /etc/nginx/nginx.conf
RUN chmod 644 /etc/nginx/nginx.conf

#setup front-end content
COPY app /usr/share/nginx/html

USER nginx
CMD ["nginx", "-g", "daemon off;"]
