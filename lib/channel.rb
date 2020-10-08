require_relative 'recipient'

module SlackCLI
  class Channel < Recipient

    CHANNEL_PATH = "https://slack.com/api/conversations.list"

    attr_reader :slack_id, :name, :topic, :member_count

    def initialize(slack_id:, name:, topic:, member_count:)
      super(name: name, slack_id: slack_id)
      @topic = topic
      @member_count = member_count
    end

    def self.list_all
      return self.get(CHANNEL_PATH, {token: ENV["SLACK_API_TOKEN"]})["channels"].map do |channel|
        self.new(slack_id: channel["id"], name: channel["name"], topic: channel["topic"]["value"], member_count: channel["num_members"])
      end
    end

  end
end