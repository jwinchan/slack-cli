require 'dotenv'
require 'httparty'

Dotenv.load

module SlackCLI
  class Workspace
    attr_reader :users, :channels

    CHANNEL_PATH = "https://slack.com/api/conversations.list"
    USER_PATH = "https://slack.com/api/users.list"
    def initialize
      env = ENV["SLACK_API_TOKEN"]
      users_response = HTTParty.get(USER_PATH, query: {token: ENV["SLACK_API_TOKEN"]})
      channels_response = HTTParty.get(CHANNEL_PATH, query: {token: ENV["SLACK_API_TOKEN"]})
      @users = users_response["members"]
      @channels = channels_response["channels"]
    end
    #user name, real name, slack Id
    def list_users
      return @users.map{|user| "Slack ID: #{user["id"]}, Username: #{user["name"]}, Real name: #{user["real_name"]}"}
    end
    #topic, member count, slack ID topic["value"]
    def list_channels
      return @channels.map{|channel| "Slack ID: #{channel["id"]}, name: #{channel["name"]}, topic: #{channel["topic"]["value"]}, member count: #{channel["num_members"]}"}
    end
  end
end