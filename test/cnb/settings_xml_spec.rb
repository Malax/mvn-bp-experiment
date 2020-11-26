require_relative "spec_helper"

describe "Heroku's Maven Cloud Native Buildpack" do
  context "when the MAVEN_SETTINGS_URL environment variable is set" do
    it "will download and use the settings.xml form that URL" do
    end

    it "will fail with a descriptive error message if that settings.xml file could not be downloaded" do
    end
  end

  context "when the MAVEN_MAVEN_SETTINGS_PATH environment variable is set" do
    it "will use that settings.xml file" do
    end
  end

  context "when the MAVEN_SETTINGS_URL and MAVEN_MAVEN_SETTINGS_PATH environment variables are set" do
    it "will give MAVEN_SETTINGS_URL precedence" do
    end
  end

  context "with an app that has a settings.xml file in the it's root directory" do
    it "will use that settings.xml file" do
    end
  end

  context "with an app that has a settings.xml file in the root directory and the MAVEN_MAVEN_SETTINGS_PATH environment variable is set" do
    it "will give MAVEN_MAVEN_SETTINGS_PATH precedence" do
    end
  end

  context "with an app that has a settings.xml file in the root directory and the MAVEN_SETTINGS_URL environment variable is set" do
    it "will give MAVEN_SETTINGS_URL precedence" do
    end
  end
end
