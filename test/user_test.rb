require_relative 'test_helper'

describe 'User' do
  describe "initialize" do
    before do
      @user = SlackCLI::User.new(slack_id: "5678id", name: "Namey Nameson", real_name: "Namey Nameson", status_text: "status", status_emoji: ":smiley:")
    end
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
end