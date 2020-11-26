#!/usr/bin/env bash

source "lib/jvm_buildpack_utils.sh"

test_get_properties_file_value() {
	assertEquals "its_value" "$(
		bputils::get_java_properties_value "custom_key" <<-EOF
		custom_key = its_value
		EOF
	)"

	assertEquals "a value with whitespace in it" "$(
		bputils::get_java_properties_value "custom_key" <<-EOF
		custom_key = a value with whitespace in it
		EOF
	)"

	assertEquals "its_value" "$(
		bputils::get_java_properties_value "custom_key" <<-EOF
		    custom_key    =    its_value
		EOF
	)"

	assertEquals "its_value" "$(
		bputils::get_java_properties_value "custom_key" <<-EOF
		custom_key=its_value
		EOF
	)"

	assertEquals "its_value" "$(
		bputils::get_java_properties_value "custom_key" <<-EOF
		custom_key:its_value
		EOF
	)"

	assertEquals "its_value" "$(
		bputils::get_java_properties_value "custom_key" <<-EOF
		# This is just a random comment.
		custom_key = its_value
		EOF
	)"

	assertEquals "its_value" "$(
		bputils::get_java_properties_value "custom_key" <<-EOF
		! Exclamation marks can also be used to start comments
		custom_key = its_value
		EOF
	)"

	local -r no_trailing_newline_properties_file=$(mktemp)
	echo -n "custom_key = its_value" >> "${no_trailing_newline_properties_file}"
	assertEquals "its_value" "$(
		bputils::get_java_properties_value "custom_key" <"${no_trailing_newline_properties_file}"
	)"

	# Besides testing the function with a file, the file also has multiple trailing spaces at the end
	# of the value. We could test this case without a file as well, but might run into issues where editors
	# remove trailing whitespace. Putting them into a file is just more robust.
	local -r trailing_spaces_properties_file=$(mktemp)
	echo "custom_key = a value   " >> "${trailing_spaces_properties_file}"
	assertEquals "a value" "$(
		bputils::get_java_properties_value "custom_key" < "${trailing_spaces_properties_file}"
	)"
}

source "vendor/shunit2"
