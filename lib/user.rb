module SlackCLI
  class User < Recipient

    attr_reader :slack_id, :name, :real_name, :status_text, :status_emoji

    def initialize(slack_id, name, real_name, status_text, status_emoji)
      super(name, slack_id)
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end
  end
end