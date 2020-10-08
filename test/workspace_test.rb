require_relative 'test_helper'

describe 'Workspace' do

  before do
    sleep(1)
    VCR.use_cassette("user_channel_find") do
      @workspace = SlackCLI::Workspace.new
    end
  end

  describe "initialize" do
    it "creates an instance of Workspace" do
      expect(@workspace).must_be_instance_of SlackCLI::Workspace
    end

    it "creates an array of User objects" do
      expect(@workspace.users).must_be_nil  #must_be_instance_of SlackCLI::User
    end

    it "creates an array of Channel objects" do
      expect(@workspace.channels.first).must_be_instance_of SlackCLI::Channel
    end
  end

  describe "list users method" do

  end

  describe "list channels method" do

  end
end