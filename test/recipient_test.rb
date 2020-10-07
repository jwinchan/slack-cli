require_relative 'test_helper'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Recipient" do

  before do
    @recipient = SlackCLI::Recipient.new()
  end

  describe "initialize" do

    it "constructor properly creates a recipient object" do

      expect(@recipient).must_be_instance_of SlackCLI::Recipient
    end

    it "slack_id and name are both strings" do
      expect(@recipient.slack_id).must_be_instance_of String
      expect(@recipient.name).must_be_instance_of String
    end
  end

  describe "self.get method" do
    it "raises ArgumentError for incorrect parameters" do
      expect{SlackCLI::Recipient.get("url", "not a hash")}.must_raise ArgumentError
    end
  end

  describe 'details' do
    it "raises error if not implemented" do
      expect(@recipient.details).must_raise NotImplementedError
    end
  end

  describe 'list_all' do
    it "raises error if not implemented" do
      expect(@recipient.list_all).must_raise NotImplementedError
    end
  end
end