#!/bin/sh
pushd `dirname $0`;

# Add jekyll --- --- header--- to all html files, so jekyll will process them
for file in `find . -name "*.html" | grep -v "/partials/"` ; do
  if head -n 1 $file | grep -q "^---$" ; then
      echo "skipping $file";
  else
      echo "processing $file";
      (echo "---"; \
       echo "---"; cat $file \
      ) > $file.tmp &&  mv -f $file.tmp $file;
  fi
done
