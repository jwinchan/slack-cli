require_relative 'test_helper'

describe 'Channel' do
  describe "initialize" do
    before do
      @channel = SlackCLI::Channel.new(slack_id: "1234id", name: "Channely Channelson", topic: "topic", member_count: 24)
    end
    it "constructor properly creates a Channel object" do
      expect(@channel).must_be_instance_of SlackCLI::Channel
    end

    it "slack_id and name are both strings" do
      expect(@channel.slack_id).must_be_instance_of String
      expect(@channel.name).must_be_instance_of String
    end

    it "topic is a String" do
      expect(@channel.topic).must_be_instance_of String
    end

    it "member count is an Integer" do
      expect(@channel.member_count).must_be_instance_of String
    end
  end
end