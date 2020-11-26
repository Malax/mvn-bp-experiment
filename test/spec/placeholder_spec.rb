require_relative "spec_helper"

describe "Heroku's Java buildpack" do

  it "Spring Boot default types" do
    Hatchet::Runner.new("test/fixtures/buildpack-java-spring-boot-test", stack: ENV["HEROKU_TEST_STACK"]).tap do |app|
      app.deploy do
        expect(app.output).to include("Procfile declares types     -> (none)")
        expect(app.output).to include("Default types for buildpack -> web")
      end
    end
  end
end
