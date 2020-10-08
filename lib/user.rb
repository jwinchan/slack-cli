require_relative 'recipient'

module SlackCLI
  class User < Recipient
    USER_PATH = "https://slack.com/api/users.list"

    attr_reader :slack_id, :name, :real_name, :status_text, :status_emoji

    def initialize(slack_id:, name:, real_name:, status_text:, status_emoji:)
      super(slack_id: slack_id, name: name)
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end

    def self.list_all
      return self.get(USER_PATH, {token: ENV["SLACK_API_TOKEN"]})["members"].map do |user|
        self.new(slack_id: user["id"], name: user["name"], real_name: user["real_name"], status_text: user["profile"]["status_text"], status_emoji: user["profile"]["status_emoji"])
      end
    end

    def details
      return "ID: #{@slack_id} \nName: #{@name} \nReal Name: #{@real_name} \nStatus: #{@status_text} \nEmoji: #{@status_emoji}"
    end



    private

    def self.from_api(json_hash)

    end


  end
end