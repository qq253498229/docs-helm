#!/usr/bin/env bash

find ./docs/en/ -iname "*.md" -exec sh -c 'pandoc "${0}" -f markdown -t html -o "${0%.md}.html"' {} \;
find ./docs/en/ -iname "*.html" -exec sh -c 'sed "1s/^/<div>/" ${0%} > test_insert_hello.html && rm -rf ${0%} && mv test_insert_hello.html ${0%}' {} \;
find ./docs/en/ -iname "*.html" -exec sh -c '(cat ${0%}; echo "</div>") > test_insert_hello.html && rm -rf ${0} && mv test_insert_hello.html ${0%}' {} \;

docker-compose build
docker-compose up -d
