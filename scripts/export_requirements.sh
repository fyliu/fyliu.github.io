#!/bin/bash

# example:
# ./scripts/export_requirements.sh --with docs

poetry export -f requirements.txt --without-hashes > requirements.txt "$@"
