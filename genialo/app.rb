require 'openai'
require 'json'

Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |f| load(f) }


OpenAI.configure do |config| 
  config.access_token = ENV['OPENAI_API_TOKEN']
end



def lambda_handler(event:, context:)

  processor = Lambda::Processor.new(event)

  processor.process_event

  return {
        'statusCode': 200
    }
end
