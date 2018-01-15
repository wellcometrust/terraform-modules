format:
	docker run --rm --tty --volume $$(pwd):/repo --workdir /repo \
		hashicorp/terraform fmt

check-format: format
	git diff --exit-code

travis-format:
	python3 _scripts/run_travis_format.py

check-release-file:
	python3 _scripts/check-release-file.py

deploy:
	python3 _scripts/deploy.py
