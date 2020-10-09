require_relative 'recipient'

module SlackCLI
  class Channel < Recipient

    attr_reader :slack_id, :name, :topic, :member_count

    def initialize(slack_id:, name:, topic:, member_count:)
      super(name: name, slack_id: slack_id)
      @topic = topic
      @member_count = member_count
    end

    def self.list_all
      return self.get("conversations.list", {token: ENV["SLACK_API_TOKEN"]})["channels"].map do |channel|
        self.new(slack_id: channel["id"], name: channel["name"], topic: channel["topic"]["value"], member_count: channel["num_members"])
      end
    end

    def details
      return "ID: #{@slack_id} \nName: #{@name} \nTopic: #{@topic} \nMember Count: #{@member_count}"
    end

    def channel_history
      response = Channel.get("conversations.history", {token: ENV["SLACK_API_TOKEN"], channel: @slack_id})
      return response["messages"].map{ |message| message["text"] }
    end
  end
end