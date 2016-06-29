#!/bin/sh
# Find legacy docs and frame them
for index in `ls */index.html` ; do
  if grep -q ".title ng-bind-template=.UI Router: {{partialTitle}}..Docs..title." $index ; then
    echo "processing legacy docs: $index";
    mv "$index" `dirname $index`/index.htm;
    cp ../assets/legacy.docs.frame.html `dirname $index`/index.html;
  fi
done


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
