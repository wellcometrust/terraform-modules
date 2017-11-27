format:
	docker run --rm --tty --volume $$(pwd):/repo --workdir /repo \
		hashicorp/terraform fmt

check-format: format
	git diff --exit-code
