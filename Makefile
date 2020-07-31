.PYHONY: default

default: .circleci/config.yml README.md

versions.json:
	./scripts/update_versions.py
	-npx prettier --write versions.json

.circleci/config.yml: versions.json ./scripts/update_config.py
	./scripts/update_config.py

README.md: versions.json ./scripts/update_readme.py
	./scripts/update_readme.py
