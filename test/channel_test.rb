require_relative 'test_helper'

describe 'Channel' do

  before do
    @channel = SlackCLI::Channel.new(slack_id: "1234id", name: "Channely Channelson", topic: "topic", member_count: 24)
  end

  describe "initialize" do
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
      expect(@channel.member_count).must_be_instance_of Integer
    end
  end

  describe "list all" do
    it "returns an array" do
      VCR.use_cassette("channel_list_all") do
        expect(SlackCLI::Channel.list_all).must_be_instance_of Array
      end
    end

    it "returns an array of Channels" do
      VCR.use_cassette("channel_list_all") do
        expect(SlackCLI::Channel.list_all.first).must_be_instance_of SlackCLI::Channel
      end
    end
  end

  describe "details method" do

    it "returns a string" do
      expect(@channel.details).must_be_instance_of String
    end

    it "returns accurate information" do
      expect(@channel.details).must_equal "ID: #{@channel.slack_id} \nName: #{@channel.name} \nTopic: #{@channel.topic} \nMember Count: #{@channel.member_count}"
    end
  end
end