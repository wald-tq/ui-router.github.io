#!/bin/sh
for file in `find . -name "*.html"` ; do 
  if head -n 1 $file | grep -q "^---$" ; then
      echo "skipping $file";
  else
      echo "processing $file";
      (echo "---"; \
       echo "---"; cat $file \
      ) > $file.tmp &&  mv -f $file.tmp $file;
  fi
done
