require 'rspec'
require_relative '../../../scripts/ruby/lib/options.rb'
require_relative '../test_setup.rb'

params = {"environment" => "development", "project" => "test_data"}
this_dir = File.dirname(__FILE__)
fixtures = "#{this_dir}/../fixtures"
general_config = "#{fixtures}/configs/general.yml"
project_simple = "#{fixtures}/configs/project_simple.yml"
project_complex = "#{fixtures}/configs/project_complex.yml"
options_test = Options.new(params, general_config, project_simple)

describe "initialize" do
  context "in a happy world" do
    it "should make a new object with an attribute" do
      options = Options.new(params, general_config, project_simple)
      expect(options.all).to be
      expect(options.all["solr_core"]).to eq("jessica_testing")
    end

    it "should override general config with project config" do
      options = Options.new(params, general_config, project_complex)
      expect(options.all).to be
      expect(options.all["solr_path"]).to eq("http://different.unl.edu:port/solr/")
      expect(options.all["tei_xsl"]).to eq("newplace.xsl")
      expect(options.all["vra_xsl"]).to eq("scripts/xslt/cdrh_to_solr/solr_transform_vra.xsl")
    end
  end
end

describe "read_config" do
  context "given a bad file path" do
    it "should exit the program" do
      # expect(options_test.read_config("fake.yml")).to raise_exception
      begin
        config = options_test.read_config("this/is/a/fake/yml.yml")
        expect(true).to be_falsey
      rescue => e
        expect(true).to be_truthy
      end
    end
  end
  context "given a good file path" do
    it "should read the stuff" do
      config = options_test.read_config("#{general_config}")
      expect(config["log_old_number"]).to eq(4)
    end
  end
end

describe "remove_environment" do
  context "given new config" do
    it "should remove the production environment and flatten development" do
      new_config = {
        "a" => "thing",
        "development" => {
          "dev" => "true"
        },
        "production" => {
          "dev" => "false",
          "another" => "hello"
        }
      }
      # options_test is preset to development environment
      output = options_test.remove_environment(new_config)
      expect(output["development"]).to be_nil
      expect(output["production"]).to be_nil
      expect(output["a"]).to eq("thing")
      expect(output["dev"]).to eq("true")
      expect(output["another"]).to be_nil
    end
  end
  # context "given new production param" it "should remove the development environment"
end

# TODO test smash_configs, also?  Already kind of being tested with initialize