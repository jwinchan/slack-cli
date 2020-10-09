require 'httparty'
require_relative 'user'
require_relative 'channel'

module SlackCLI
  class Workspace
    attr_reader :users, :channels

    def initialize
      @users = User.list_all
      @channels = Channel.list_all
    end

    #user name, real name, slack Id
    def list_users
      return @users.map{|user| "Slack ID: #{user.slack_id}\nUsername: #{user.name}\nReal name: #{user.real_name}\n"}
    end

    #topic, member count, slack ID, topic["value"]
    def list_channels
      return @channels.map{|channel| "Slack ID: #{channel.slack_id}\nName: #{channel.name}\nTopic: #{channel.topic}\nMember count: #{channel.member_count}\n"}
    end

    def select(recipient_class, identifier)
      raise ArgumentError.new("Argument cannot be empty") if(identifier == nil)
      raise ArgumentError.new("Recipient class must be user or channel") unless recipient_class == SlackCLI::User || recipient_class == SlackCLI::Channel
      recipient_class.select(identifier)
    end

    def show_details(recipient)
      return recipient.details
    end

    def send_message(message, recipient_id)

      response = HTTParty.post(
          "https://slack.com/api/chat.postMessage",
          body:  {
              token: ENV["SLACK_API_TOKEN"],
              text: message,
              channel: recipient_id,
              as_user: "true"
          },
          headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
      )

      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackAPIError.new("Error: #{response.parsed_response["error"]}")
      end

      return true
    end

    def conversation_history(channel_id)
      response = HTTParty.get("https://slack.com/api/conversations.history", query: {token: ENV["SLACK_API_TOKEN"], channel: channel_id})
      return response["messages"].map{ |message| message["text"] }
    end
  end
end