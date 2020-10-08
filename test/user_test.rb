require_relative 'test_helper'

describe 'User' do
  before do
    @user = SlackCLI::User.new(slack_id: "5678id", name: "Namey Nameson", real_name: "Namey Nameson", status_text: "status", status_emoji: ":smiley:")
  end

  describe "initialize" do

    it "constructor properly creates a Channel object" do
      expect(@user).must_be_instance_of SlackCLI::User
    end

    it "slack_id and name are both strings" do
      expect(@user.slack_id).must_be_instance_of String
      expect(@user.name).must_be_instance_of String
    end

    it "real name is a String" do
      expect(@user.real_name).must_be_instance_of String
    end

    it "status text is an String" do
      expect(@user.status_text).must_be_instance_of String
    end

    it "status emoji is an String" do
      expect(@user.status_emoji).must_be_instance_of String
    end
  end

  describe "list all" do
    it "returns an array" do
      VCR.use_cassette("user_list_all") do
        expect(SlackCLI::User.list_all).must_be_instance_of Array
      end
    end

    it "returns an array of Users" do
      VCR.use_cassette("user_list_all") do
        expect(SlackCLI::User.list_all.first).must_be_instance_of SlackCLI::User
      end
    end
  end

  describe "details method" do

    it "returns a string" do
      expect(@user.details).must_be_instance_of String
    end

    it "returns accurate information" do
      expect(@user.details).must_equal "ID: #{@user.slack_id} \nName: #{@user.name} \nReal Name: #{@user.real_name} \nStatus: #{@user.status_text} \nEmoji: #{@user.status_emoji}"
    end
  end
end