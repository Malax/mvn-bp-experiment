require_relative "spec_helper"

describe "Heroku's Maven Cloud Native Buildpack" do
  it "will write ${APP_DIR}/target/mvn-dependency-list.log with the app's dependencies" do
  end

  it "will not leave unexpected files in ${APP_DIR}" do
  end

  it "will not log internal Maven options and goals" do
  end

  it "will cache dependencies between builds" do
  end

  context "with an app that does not compile" do
    it "will exit with a descriptive error message" do
    end
  end
end
