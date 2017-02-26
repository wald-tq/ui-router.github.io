#!/bin/sh
pushd `dirname $0`;

find . -type d -depth 1 | sort | grep -v "ngdoc" | node ./paths_as_json_array.js > versions.json

for i in `find . -type d -depth 1` ; do
  pushd $i;
  find . -name "*.html" | sort | node ../paths_as_json_array.js > files.json
  popd;
done

