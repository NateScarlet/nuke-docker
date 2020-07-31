#!/bin/bash

set -ex
if [ -z "$(git status -s versions.json)" ]; then exit 0; fi
git commit -a -m "ci: update versions.json"
