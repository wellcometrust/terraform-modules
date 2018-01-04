format:
	docker run --rm --tty --volume $$(pwd):/repo --workdir /repo \
		hashicorp/terraform fmt

check-format: format
	git diff --exit-code

check-release-file:
	python _scripts/check-release-file.py

deploy:
	python _scripts/deploy.py
