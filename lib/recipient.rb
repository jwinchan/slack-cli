require 'dotenv'
require 'httparty'
require_relative 'slackapierror'

Dotenv.load

module SlackCLI
  class Recipient

    attr_reader :name, :slack_id
    def initialize(slack_id:, name:)
      self.class.validate_id(slack_id)
      @slack_id = slack_id
      @name = name
    end

    def self.validate_id(id)
      if id.nil?
        raise ArgumentError, 'ID cannot be blank.'
      end
    end

    def self.get(end_point, params)
      raise ArgumentError.new("invalid arguments") unless (end_point.is_a?(String) && params.is_a?(Hash))
      response = HTTParty.get("https://slack.com/api/#{end_point}", query: params)
      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackAPIError.new("Error: #{response.parsed_response["error"]}")
      end
      return response
    end

    def details
      raise NotImplementedError, 'Implement me in a child class!'
    end

    def self.list_all
      raise NotImplementedError, 'Implement me in a child class!'
    end

    def self.select(identifier)
      return self.list_all.find{|recipient| recipient.slack_id == identifier || recipient.name == identifier}
    end

    def send_message(message)

      response = HTTParty.post(
          "https://slack.com/api/chat.postMessage",
          body:  {
              token: ENV["SLACK_API_TOKEN"],
              text: message,
              channel: @slack_id,
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