#!/bin/sh

# Add redirect_from: /docs/latest to headers to redirect
for file in `find . -name "*.html" | grep -v "/partials/"` ; do
  if head -n 1 $file | grep -q "^---$" ; then
    echo "processing $file";
    frompath=`echo $file | sed -e 's/^\.//' -e 's/index.html//'`;
    echo "redirect from /docs$frompath"
    perl -i.bak -0 -pe "s|^---\n---|---\nredirect_from: /docs$frompath\n---|" $file
  else
    echo "skipping $file";
  fi
done

