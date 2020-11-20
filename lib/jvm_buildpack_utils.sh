##
# Reads a value from Java properties fed into STDIN. Only works for simple use-cases and does not support escape
# sequences or multiline keys/values. It also aggressively trims keys/values which is not part of the specification.
# However, it supports all cases that JVM buildpacks historically did support.
#
# See: https://docs.oracle.com/javase/10/docs/api/java/util/Properties.html#load(java.io.Reader)
##
bputils::get_java_properties_value() {
	local -r key=${1:?}
	local -r regex="^ *([^= ]*)[=: ]+(.*)$"

	local line
	while IFS="" read -r line; do
		if [[ "${line}" =~ $regex && ${BASH_REMATCH[1]} == "${key}" ]]; then
			# shellcheck disable=SC2001
			echo "${BASH_REMATCH[2]}" | sed -e 's/[[:space:]]*$//'
			return
		fi
	done

	false
}

bputils::download_and_extract_tarball() {
	local -r tarball_url="${1:?}"
	local -r target_directory="${2:?}"
	curl --retry 3 --silent --max-time 60 --location "${tarball_url}" | tar -xzm -C "${target_directory}"
}

bputils::download_file() {
	local -r url="${1:?}"
	local -r target_path="${2:?}"
	curl --retry 3 --silent --max-time 10 --location "${url}" --output "${target_path}"
}
