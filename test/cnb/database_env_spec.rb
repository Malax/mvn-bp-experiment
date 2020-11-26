require_relative "spec_helper"

describe "Heroku's Maven Cloud Native Buildpack" do
  context "when the DATABASE_URL environment variable is set" do
    it "will provide JDBC_DATABASE_URL based on DATABASE_URL during build" do
    end

    it "will provide JDBC_DATABASE_USERNAME based on DATABASE_URL during build" do
    end

    it "will provide JDBC_DATABASE_PASSWORD based on DATABASE_URL during build" do
    end
  end
end
