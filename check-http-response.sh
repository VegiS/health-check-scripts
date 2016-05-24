#!/usr/bin/env bash

if [[ -z "$1" ]]; then
 echo -e "The script checks if given URI (Uniform Resource Identifier) is responding HTTP status code 200\n
 URI = http(s)://example.com:8042/over/there?name=ferret#nose
        \_____/\_________________/\_________/\_________/\__/
            |           |               |         |      |
         scheme     authority          path     query  fragment
            |   ________________________|__
           / \ /                           \\
           urn:example:animal:ferret:nose\n"
  echo "Usage: ./check-http-response.sh <URI>"
 exit 1
fi

echo "CHECK if $1 is up"

testHttp200=$(curl -sL -w '%{http_code}' $1 -o /dev/null 2>&1 | grep 200)

if [ "$testHttp200" != "200" ]; then
  echo "ERROR - no HTTP status code 200 received!"
  exit 1
fi

echo "OK - HTTP status code 200 received"