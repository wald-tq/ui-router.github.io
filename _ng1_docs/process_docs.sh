#!/bin/sh
pushd `dirname $0`;

./process_legacy_docs.sh
./process_typedoc_docs.sh
./create_metadata.sh
./add_redirects.sh
