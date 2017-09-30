#!/bin/sh

cwd=`dirname "$0"`
expr "$0" : "/.*" > /dev/null || cwd=`(cd "$cwd" && pwd)`

$cwd/create-datasource.sh

$cwd/create-docdb-init-dbcol.sh

$cwd/create-indexer.sh

echo "All done!"
