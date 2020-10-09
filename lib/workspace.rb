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

    def list_users
      return @users.map{|user| {id: user.slack_id, name: user.name, real_name: user.real_name} }
    end

    def list_channels
      return @channels.map{|channel| {id: channel.slack_id, name: channel.name, topic: channel.topic, member_count: channel.member_count}}
    end

    def select(recipient_class, identifier)
      raise ArgumentError.new("Argument cannot be empty") if(identifier == nil)
      raise ArgumentError.new("Recipient class must be user or channel") unless recipient_class == SlackCLI::User || recipient_class == SlackCLI::Channel
      recipient_class.select(identifier)
    end

    def show_details(recipient)
      return recipient.details
    end

    def send_message(message, recipient)
      raise ArgumentError.new("recipient must be of Recipient class") unless recipient.is_a? Recipient
      recipient.send_message(message)
    end

    def conversation_history(channel)
      return channel.channel_history
    end
  end
end