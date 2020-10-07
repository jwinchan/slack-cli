require_relative 'recipient'

module SlackCLI
  class Channel < Recipient

    attr_reader :slack_id, :name, :topic, :member_count

    def initialize(slack_id:, name:, topic:, member_count:)
      super(name, slack_id)
      @topic = topic
      @member_count = member_count
    end

  end
end