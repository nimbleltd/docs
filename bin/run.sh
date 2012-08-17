#!/bin/bash 
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp "${DIR}/../src/style.css" "${DIR}/../server/style.css"
bfdocs --server --port=4444 --watch "${DIR}/../src/manifest.json" "${DIR}/../server"
