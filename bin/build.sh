#!/bin/bash 
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp "${DIR}/../docs/style.css" "${DIR}/../style.css"
bfdocs --base-url=/docs "${DIR}/../docs/manifest.json" "${DIR}/.."
