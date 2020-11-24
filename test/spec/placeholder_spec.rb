require_relative "spec_helper"

describe "Heroku's Java buildpack" do

  it "spring boot thing" do
    Hatchet::Runner.new("test/spec/fixtures/buildpack-java-spring-boot-test", stack: ENV["HEROKU_TEST_STACK"]).tap do |app|
      app.before_deploy do
        set_java_version(DEFAULT_OPENJDK_VERSION)
      end

      app.deploy do
        expect(app.output).to include("what")
      end
    end
  end
end
