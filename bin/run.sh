#!/bin/bash 
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
bfdocs --server --port=4444 --watch "${DIR}/../docs/manifest.json" "${DIR}/../server"
