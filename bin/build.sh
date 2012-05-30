#!/bin/bash 
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
bfdocs --base-url=/docs "${DIR}/../docs/manifest.json" "${DIR}/.."
