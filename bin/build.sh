#!/bin/bash 
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp "${DIR}/../src/style.css" "${DIR}/../style.css"
bfdocs --base-url=/docs "${DIR}/../src/manifest.json" "${DIR}/.."
