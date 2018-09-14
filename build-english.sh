#!/usr/bin/env bash

# 英文文档生成HTML
find ./docs/en/ -iname "*.md" -exec sh -c 'pandoc "${0}" -f markdown -t html -s --metadata pagetitle="Helm英文文档" --css="https://codeforfun.oss-cn-beijing.aliyuncs.com/markdown2html.css" -o "${0%.md}.html"' {} \;
find ./docs/en/ -iname "*.html" -exec sh -c 'sed "1s/^/<div>/" ${0%} > test_insert_hello.html && rm -rf ${0%} && mv test_insert_hello.html ${0%}' {} \;
find ./docs/en/ -iname "*.html" -exec sh -c '(cat ${0%}; echo "</div>") > test_insert_hello.html && rm -rf ${0} && mv test_insert_hello.html ${0%}' {} \;
