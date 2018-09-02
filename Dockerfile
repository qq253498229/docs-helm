# 将markdown转换成html
FROM ubuntu:16.04 as builder

ENV PANDOC_VERSION=2.2.3.2

RUN apt-get update \
    && apt-get install -y wget \
    && wget https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux.tar.gz \
    && tar zxvf pandoc-${PANDOC_VERSION}-linux.tar.gz \
    && mv pandoc-${PANDOC_VERSION}/bin/pandoc /usr/local/bin/ \
    && rm -rf pandoc-*
WORKDIR /tmp
COPY . .
RUN find src/docs/cn -iname "*.md" -exec sh -c 'pandoc "${0}" -f markdown -t html -o "${0%.md}.html"' {} \; \
    && find src/docs/cn/ -iname "*.html" -exec sh -c 'sed "1s/^/<div>/" ${0%} > test_insert_hello.html && rm -rf ${0%} && mv test_insert_hello.html ${0%}' {} \; \
    && find src/docs/cn/ -iname "*.html" -exec sh -c '(cat ${0%}; echo "</div>") > test_insert_hello.html && rm -rf ${0} && mv test_insert_hello.html ${0%}' {} \;


# 编译vue环境
FROM node:10-alpine as builder1

WORKDIR /tmp

COPY --from=builder /tmp .
RUN npm set progress=false && npm config set depth 0 && npm cache clean --force && npm i
RUN npm run build


# 配置nginx
FROM nginx:1.15-alpine

COPY default.conf /etc/nginx/conf.d/
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder1 /tmp/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
