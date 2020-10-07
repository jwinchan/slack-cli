require_relative 'recipient'

module SlackCLI
  class User < Recipient

    USER_URL = "https://slack.com/api/users.list"
    PARAM = {token: ENV["SLACK_API_TOKEN"]}

    attr_reader :slack_id, :name, :real_name, :status_text, :status_emoji

    def initialize(slack_id:, name:, real_name:, status_text:, status_emoji:)
      super(slack_id: slack_id, name: name)
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end



    private

    def self.from_api(json_hash)

    end


  end
end