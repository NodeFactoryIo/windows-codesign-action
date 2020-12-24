#!/bin/bash -l

set -e

istrue () {
  case $1 in
    "true"|"yes"|"y") return 0;;
    *) return 1;;
  esac
}

echo "--> outputting keystore to file"
mkdir /certs
# The quotations around the cert/key vars are very import to handle line breaks
echo "${INPUT_KEYSTORE}" | xargs | base64 -d > /certs/bundle.pfx

echo "--> signing binary"
/usr/local/bin/osslsigncode sign -pkcs12 /certs/bundle.pfx -pass ${INPUT_PASSWORD} -n ${INPUT_APPNAME} -i ${INPUT_DOMAIN} -t "http://timestamp.verisign.com/scripts/timstamp.dll" -in ${INPUT_BINARYPATH} -out /signedbinary

echo "--> overwriting existing binary with signed binary"
cp /signedbinary ${INPUT_BINARYPATH}

if istrue "$INPUT_VERIFY"; then /usr/local/bin/osslsigncode verify -in ${INPUT_BINARYPATH}; fi
