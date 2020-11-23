#!/usr/bin/env bash

dependencies::has_spring_boot() {
	local app_directory=${1:?}

	[[ -f "${app_directory}/pom.xml" ]] &&
		[[ -n "$(grep "<groupId>org.springframework.boot" "${app_directory}/pom.xml")" ]] &&
		[[ -n "$(grep "<artifactId>spring-boot" "${app_directory}/pom.xml")" ]]
}

dependencies::has_wildfly_swarm() {
	local app_directory=${1:?}
	[[ -f "${app_directory}/pom.xml" ]] && [[ -n "$(grep "<groupId>org.wildfly.swarm" "${app_directory}/pom.xml")" ]]
}

dependencies::app_requires_postgres() {
	local app_directory=${1:?}

	[[ -f "${app_directory}/pom.xml" ]] &&
		{
			[[ -n "$(grep "<groupId>org.postgresql" "${app_directory}/pom.xml")" ]] ||
				[[ -n "$(grep "<groupId>postgresql" "${app_directory}/pom.xml")" ]] ||
				[[ -n "$(grep "<groupId>com.impossibl.pgjdbc-ng" "${app_directory}/pom.xml")" ]];
		}
}
