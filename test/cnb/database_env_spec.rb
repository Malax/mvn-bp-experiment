require_relative "spec_helper"

describe "Heroku's Maven Cloud Native Buildpack" do
  # This test can potentially be moved to the heroku/jvm buildpack in the future as it's the buildpack that
  # provides this functionality.
  context "when the DATABASE_URL environment variable is set" do
    it "will provide JDBC_DATABASE_URL, JDBC_DATABASE_USERNAME, and JDBC_DATABASE_PASSWORD based on DATABASE_URL during build" do
      with_temporary_app_from_fixture("simple-http-service") do |app_dir|
        pack_build(app_dir, buildpacks: ["heroku/jvm", :this, "heroku/procfile"], env: { DATABASE_URL: "postgres://AzureDiamond:hunter2@db.example.com:5432/testdb"}) do |pack_result|
          expect(pack_result.stdout).to include("[BUILDPACK INTEGRATION TEST - JDBC_DATABASE_URL] jdbc:postgresql://db.example.com:5432/testdb?password=hunter2&sslmode=require&user=AzureDiamond")
          expect(pack_result.stdout).to include("[BUILDPACK INTEGRATION TEST - JDBC_DATABASE_USERNAME] AzureDiamond")
          expect(pack_result.stdout).to include("[BUILDPACK INTEGRATION TEST - JDBC_DATABASE_PASSWORD] hunter2")
        end
      end
    end
  end
end
