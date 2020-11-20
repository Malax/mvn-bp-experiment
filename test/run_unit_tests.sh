#!/usr/bin/env bash

# TODO: Run all tests, but remember if any failed and exit with non-zero as well.

for file in ./test/*_test.sh; do
	echo "======================================================"
	echo "${file}"
	echo "======================================================"
	(./"${file}")
done
