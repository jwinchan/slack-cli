require 'dotenv'
require 'httparty'

Dotenv.load

module SlackCLI
  class Recipient

    attr_reader :name, :slack_id
    def initialize(slack_id: , name: )
      @slack_id = slack_id
      @name = name
    end

    def self.get(url, params)
      raise ArgumentError.new("invalid arguments") unless (url.is_a?(String) && params.is_a?(Hash))
      api_info = HTTParty.get(url, query: params)
      return api_info
    end

    def details
      raise NotImplementedError, 'Implement me in a child class!'
    end

    def self.list_all
      raise NotImplementedError, 'Implement me in a child class!'
    end

  end
end