require_relative "spec_helper"

DEFAULT_MAVEN_VERSION="3.6.2"
PREVIOUS_MAVEN_VERSION="3.5.4"
UNKNOWN_MAVEN_VERSION="1.0.0-unknown-version"

describe "Heroku's Maven Cloud Native Buildpack" do
  context "for an app that has both Maven Wrapper and a 'maven.version=#{PREVIOUS_MAVEN_VERSION}' in its system.properties file" do
    it "will install Maven #{PREVIOUS_MAVEN_VERSION}" do
    end

    it "will not execute Maven wrapper" do
    end
  end

  context "for an app that has both Maven Wrapper and a 'maven.version=#{UNKNOWN_MAVEN_VERSION}' in its system.properties file" do
    it "will fail with a descriptive error message" do
    end
  end

  context "for an app without Maven wrapper" do
    context "without 'maven.version' in its system.properties file" do
      it "will install Maven #{DEFAULT_MAVEN_VERSION}" do
      end
    end

    context "with 'maven.version=#{UNKNOWN_MAVEN_VERSION}' in its system.properties file" do
      it "will fail with a descriptive error message" do
      end
    end

    context "with 'maven.version=3.6.2' in its system.properties file" do
      it "will install Maven 3.6.2" do
      end
    end

    context "with 'maven.version=3.5.4' in its system.properties file" do
      it "will install Maven 3.5.4" do
      end
    end

    context "with 'maven.version=3.3.9' in its system.properties file" do
      it "will install Maven 3.3.9" do
      end
    end

    context "with 'maven.version=3.2.5' in its system.properties file" do
      it "will install Maven 3.2.5" do
      end
    end
  end
end
