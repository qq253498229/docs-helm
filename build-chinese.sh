#!/usr/bin/env bash

find ./docs/cn/ -iname "*.adoc" -exec sh -c 'asciidoctor "${0}"' {} \;