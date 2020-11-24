# Generic 
- Scenario: No Maven Wrapper, no `maven.version`
    - Check if default version is correct
- Scenario: No Maven Wrapper, explicit `maven.version`
- Scenario: No Maven Wrapper, explicit, but incorrect `maven.version`
- Scenario: Maven Wrapper without explicit `maven.version`
- Scenario: Maven Wrapper with explicit `maven.version`
    - Check if warning is displayed
    - Check if Maven is installed and used instead of wrapper
- Check caching of resolved dependencies
- Check `target/mvn-dependency-list.log` presence
- Check failing build error message
- Check that there is no Maven residue in app directory
    - With Wrapper
    - Without Wrapper
- Check `JDBC_DATABASE_*` env var support during build
- Maven `settings.xml` support:
    - `MAVEN_SETTINGS_URL` support
        - Check error case with `404` urls
    - `MAVEN_MAVEN_SETTINGS_PATH` support
    - Support for `settings.xml` in app directory
    - Check correct precedence
- `MAVEN_CUSTOM_OPTS` support
- `MAVEN_CUSTOM_GOALS` support
    - Check `target/mvn-dependency-list.log` presence when custom goals are specified
- Check automatic process types:
    - Wildfly Swarm
    - Spring Boot

# Classic
- Check if correct metrics are logged (requires another buildpack for support)
- Check if Maven is installed on CI
- Check `JVM_COMMON_BUILDPACK` support

# CNB
- Check if subsequent buildpacks can use Maven
- Check if subsequent buildpacks can use cached dependencies
