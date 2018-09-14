FROM nginx:1.15-alpine

COPY default.conf /etc/nginx/conf.d/
RUN rm -rf /usr/share/nginx/html/*
COPY docs /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
