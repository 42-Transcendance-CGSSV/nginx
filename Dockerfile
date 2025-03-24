FROM node:23.10-alpine
LABEL authors="jbadaire"

RUN apk add --no-cache nginx

WORKDIR /app

EXPOSE $PORT
ENTRYPOINT ["/bin/sh", "entrypoint.sh"]
