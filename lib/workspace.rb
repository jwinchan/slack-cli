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
      return @users.map{|user| "Slack ID: #{user.slack_id}, Username: #{user.name}, Real name: #{user.real_name}"}
    end

    #topic, member count, slack ID, topic["value"]
    def list_channels
      return @channels.map{|channel| "Slack ID: #{channel.slack_id}, name: #{channel.name}, topic: #{channel.topic}, member count: #{channel.member_count}"}
    end

    def select(recipient_class:, name: nil, id: nil)
      raise ArgumentError.new("Both arguments cannot be empty at once") if(name == nil && id == nil)

      if(recipient_class == "user")
        if name
          return @users.find{|user| user.name == name}
        else
          return @users.find{|user| user.slack_id == id}
        end
      end

      if(recipient_class == "channel")
        if name
          return @channels.find{|channel| channel.name == name}
        else
          return @channels.find{|channel| channel.slack_id == id}
        end
      end

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


  end
end