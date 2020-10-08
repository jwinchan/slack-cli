require_relative 'test_helper'

describe 'Workspace' do

  before do
    VCR.use_cassette("user_channel_find") do
      @workspace = SlackCLI::Workspace.new
    end
  end

  describe "initialize" do
    it "creates an instance of Workspace" do
      expect(@workspace).must_be_instance_of SlackCLI::Workspace
    end

    it "creates an array of User objects" do
      expect(@workspace.users.first).must_be_instance_of SlackCLI::User
    end

    it "creates an array of Channel objects" do
      expect(@workspace.channels.first).must_be_instance_of SlackCLI::Channel
    end
  end

  describe "list users method" do
    it "returns an accurate string" do
      expect(@workspace.list_users.first).must_equal "Slack ID: USLACKBOT, Username: slackbot, Real name: Slackbot"
    end
  end

  describe "list channels method" do
    it "returns an accurate string" do
      expect(@workspace.list_channels.first).must_equal "Slack ID: C01BL0GSPP1, name: good-place-simulation, topic: torture Chidi, member count: 2"
    end
  end
end