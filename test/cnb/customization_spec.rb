require_relative "spec_helper"

describe "Heroku's Maven Cloud Native Buildpack" do
  context "with the CUSTOM_MAVEN_GOALS environment variable set" do
    it "will only use goals from CUSTOM_MAVEN_GOALS" do
    end

    # This is implemented by using the dependency:list goal. We need to ensure it won't be overwritten by
    # the user's choice of goals.
    it "will still create ${APP_DIR}/target/mvn-dependency-list.log" do
    end
  end

  context "with the MAVEN_CUSTOM_OPTS environment variable set" do
    it "will only use options from MAVEN_CUSTOM_OPTS" do
    end
  end
end
