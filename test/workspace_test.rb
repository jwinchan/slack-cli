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
    it "returns an accurate hash" do
      expect(@workspace.list_users.first).must_equal ({:id=>"USLACKBOT", :name=>"slackbot", :real_name=>"Slackbot"})
    end
  end

  describe "list channels method" do
    it "returns accurate hash" do
      expect(@workspace.list_channels.first).must_equal ({:id=>"C01BL0GSPP1", :name=>"good-place-simulation", :topic=>"torture Chidi", :member_count=>2})
    end
  end

  describe "select method" do

    it "raises ArgumentError if name or id isn't provided" do
      VCR.use_cassette("invalid_select") do
        expect{@workspace.select(SlackCLI::User, nil)}.must_raise ArgumentError
      end
    end

    it "raises ArgumentError if class isn't User or Channel" do
      VCR.use_cassette("invalid_select") do
        expect{@workspace.select(Array, "USLACKBOT")}.must_raise ArgumentError
      end
    end

    it "returns correct User" do
      VCR.use_cassette("select_user") do
        expect(@workspace.select(SlackCLI::User, "USLACKBOT").name).must_equal "slackbot"
      end
    end

    it "returns correct Channel" do
      VCR.use_cassette("select_channel") do
        expect(@workspace.select(SlackCLI::Channel, "general").slack_id).must_equal "C01BU0NRFHC"
      end
    end
  end

  describe "show details method" do
    before do
      @user = SlackCLI::User.new(slack_id: "1234asdf", name: "testname", real_name: "bob", status_text: "i am a status", status_emoji: ":grr:")
    end

    it "returns a string" do
      expect(@workspace.show_details(@user)).must_be_instance_of String
    end

    it "returns accurate information" do
      expect(@workspace.show_details(@user)).must_equal @user.details
    end
  end

  describe "send_message method" do
    it "can send a valid message to user" do
      VCR.use_cassette("slack-posts-user") do
        response = @workspace.send_message("Test Test Test", "U01C6TTNL6Q")
        expect(response).must_equal true
      end
    end

    it "can send a valid message to channel" do
      VCR.use_cassette("slack-posts-channel") do
        response = @workspace.send_message("Test Test Test", "C01BU0NRFHC")
        expect(response).must_equal true
      end
    end

    it "returns an error if no recipient selected" do
      VCR.use_cassette("slack-posts-no-recipient") do
        expect{@workspace.send_message("Test Test Test", nil)}.must_raise SlackCLI::SlackAPIError
      end
    end

    it "returns an error if wrong channel selected" do
      VCR.use_cassette("slack-posts-wrong-channel") do
        expect{@workspace.send_message("Test Test Test", "2i3nfidl")}.must_raise SlackCLI::SlackAPIError
      end
    end
  end

  describe "conversation history method" do
    it "returns an Array" do
      VCR.use_cassette("channel_history") do
        expect(@workspace.conversation_history("C01BL0GSPP1")).must_be_instance_of Array
      end
    end

    it "returns an Array of Strings" do
      VCR.use_cassette("channel_history") do
        expect(@workspace.conversation_history("C01BL0GSPP1").first).must_be_instance_of String
      end
    end

    it "returns accurate information" do
      VCR.use_cassette("channel_history") do
        expect(@workspace.conversation_history("C01BL0GSPP1").first).must_equal "make Chidi choose a puppy"
      end
    end
  end
end