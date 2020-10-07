require_relative 'test_helper'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


describe "initialize" do
  before do
    @recipient = SlackCLI::Recipient.new("1234ID", "Namey Nameson")
  end
  it "constructor properly creates a recipient object" do

    expect(@recipient).must_be_instance_of SlackCLI::Recipient
  end

  it "slack_id and name are both strings" do
    expect(@recipient.slack_id).must_be_instance_of String
    expect(@recipient.name).must_be_instance_of String
  end
end