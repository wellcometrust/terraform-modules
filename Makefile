format:
	docker run --rm --tty --volume $$(pwd):/repo --workdir /repo \
		hashicorp/terraform fmt

check-format: format
	git diff --exit-code

travis-format:
	python _scripts/run_travis_format.py

check-release-file:
	python _scripts/check-release-file.py

deploy:
	python _scripts/deploy.py
