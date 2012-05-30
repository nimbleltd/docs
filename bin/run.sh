#!/bin/bash 
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp "${DIR}/../docs/style.css" "${DIR}/../server/style.css"
bfdocs --server --port=4444 --watch "${DIR}/../docs/manifest.json" "${DIR}/../server"
