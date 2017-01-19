#!/bin/sh
# Find legacy docs and frame them
pushd `dirname $0`;

for file in `ls */index.html` ; do
  if grep -q ".title ng-bind-template=.UI Router: {{partialTitle}}..Docs..title." $file ; then
    if head -n 1 $file | grep -q "^---$" ; then
      echo "skipping $file";
    else
      echo "processing legacy docs: $file";
      (echo "---"; \
       echo "---"; \
       echo "{% raw %}"; \
       cat $file | sed -e 's/navbar-fixed-top//g'; \
       echo "{% endraw %}"; \
      ) > $file.tmp &&  mv -f $file.tmp $file;
    fi
  fi
done

