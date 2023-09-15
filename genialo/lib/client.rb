require 'openai'
# Create a new instance of the OpenAI client
module Client
  OpenAI.configure do |config|
    config.api_key = ENV['OPENAI_API_KEY']
  end

  Chat = OpenAI::Client.new(
  )
end