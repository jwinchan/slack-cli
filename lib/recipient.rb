module SlackCLI
  class Recipient

    attr_reader :name, :slack_id
    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end
  end
end