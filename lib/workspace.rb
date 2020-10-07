require 'dotenv'
require 'httparty'

Dotenv.load

class Workspace
  attr_reader :users, :channels

  CHANNEL_PATH = "https://slack.com/api/conversations.list"

  def initialize
    response = HTTParty.get(CHANNEL_PATH, query: {token: ENV["SLACK_API_TOKEN"]})
    @users = []
    @channels = response["channels"]
  end



end