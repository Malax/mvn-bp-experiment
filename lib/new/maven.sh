function detect_maven_version() {
	local -r app_directory="${1:?}"
	local -r default_version="${2:?}"
	local -r system_properties_path="${app_directory}/system.properties"

	local selected_version=""
	if [[ -f "${system_properties_path}" ]]; then
		selected_version=$(get_java_properties_value "maven.version" <"${system_properties_path}")
	fi

	echo "${selected_version:-$default_version}"
}

function get_maven_tarball_url() {
	local -r maven_version="${1:?}"

	declare -A maven_tarball_urls
	maven_tarball_urls[1.0.0]="https://whatever.tar.gz"
	maven_tarball_urls[2.0.0]="https://whatever.tar.gz"
	maven_tarball_urls[3.0.0]="https://whatever.tar.gz"
	maven_tarball_urls[4.0.0]="https://whatever.tar.gz"

	echo "${maven_tarball_urls["${maven_version}"]}"
}

function has_maven_wrapper() {
	local -r app_directory="${1:?}"
	[[ -f "${app_directory}/mvnw" && -f "${app_directory}/.mvn/wrapper/maven-wrapper.properties" ]]
}
