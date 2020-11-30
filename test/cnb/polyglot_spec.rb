require_relative "spec_helper"

describe "Heroku's Maven Cloud Native Buildpack" do
  context "with a polyglot Maven app" do
    it "will pass the detect phase and build the app successfully" do
      with_temporary_app_from_fixture("simple-http-service-groovy-polyglot") do |app_dir|
        pack_build(app_dir, buildpacks: ["heroku/jvm", :this, "heroku/procfile"]) do |pack_result|
          expect(pack_result.stdout).to include("[INFO] BUILD SUCCESS")
        end
      end
    end
  end
end
