format:
	./run_terraform.sh fmt

check-format: format
	git diff --exit-code
