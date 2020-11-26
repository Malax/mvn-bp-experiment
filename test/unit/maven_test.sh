source "lib/maven.sh"

test_maven_tarball_url_for_version() {
	assertEquals "" "$(maven::tarball_url_for_version "2.0.0")"
}

source "vendor/shunit2"
