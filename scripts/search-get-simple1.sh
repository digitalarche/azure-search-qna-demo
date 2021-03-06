#!/bin/sh

cwd=`dirname "$0"`
expr "$0" : "/.*" > /dev/null || cwd=`(cd "$cwd" && pwd)`
. $cwd/search.conf

# URL encode: "Azure Search" -> %22Azure%20Search%22
KEYWORD="%22Azure%20Search%22"

{
curl -s\
 -H "Content-Type: application/json"\
 -H "api-key: $AZURE_SEARCH_ADMIN_KEY"\
 -XGET "https://$AZURE_SEARCH_SERVICE_NAME.search.windows.net/indexes/$AZURE_SEARCH_INDEX_NAME/docs?api-version=$AZURE_SEARCH_API_VER"\
"&\$top=50"\
"&\$select=question,answer"\
"&\$count=true"\
"&searchMode=all"\
"&queryType=simple"\
"&search=$KEYWORD"
} | python -mjson.tool| perl -Xpne 's/\\u([0-9a-fA-F]{4})/chr(hex($1))/eg'
