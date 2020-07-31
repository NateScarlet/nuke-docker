#!/bin/bash

set -ex
if [ -z "$(git status -s)" ]; then exit 0; fi
git commit -a -m "chore: ci update"
