#!/bin/sh
for file in `find . -name "*.html"` ; do 
  if grep -q "jekyll-header: true" $file ; then
      echo "skipping $file";
  else
      echo "processing $file";
      (echo "---"; \
       echo "layout: docs"; \
       echo "jekyll-header: true" ; \
       echo "---"; cat $file \
      ) > $file.tmp &&  mv -f $file.tmp $file;
  fi
done
