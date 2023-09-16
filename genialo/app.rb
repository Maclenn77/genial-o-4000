require 'openai'
require 'json'
require 'logger'

Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |f| load(f) }


OpenAI.configure do |config| 
  config.access_token = ENV['OPENAI_API_TOKEN']
end



def lambda_handler(event:, context:)
  logger = Logger.new($stdout)
  # Sample pure Lambda function

  # Parameters
  # ----------
  # event: Hash, required
  #     API Gateway Lambda Proxy Input Format
  #     Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-input-format

  # context: object, required
  #     Lambda Context runtime methods and attributes
  #     Context doc: https://docs.aws.amazon.com/lambda/latest/dg/ruby-context.html

  # Returns
  # ------
  # API Gateway Lambda Proxy Output Format: dict
  #     'statusCode' and 'body' are required
  #     # api-gateway-simple-proxy-for-lambda-output-format
  #     Return doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html

  # begin
  #   response = HTTParty.get('http://checkip.amazonaws.com/')
  # rescue HTTParty::Error => error
  #   puts error.inspect
  #   raise error
  # end

  body = JSON.parse(event.dig("body"))
  client = Clients::OpenAI.new

  if telegram_message?(body)
    puts "telegram message"
    prompt = body.dig("message", "text") || "Inform user that there was a problem with the request."
    chat_id = body.dig("message", "chat", "id")
  elsif api_request?(body)
    puts "API Request"
    puts "Event class: #{event.class}"
    puts event.dig("body")
    prompt = body.dig("prompt")
    puts "Prompt: #{prompt}"
  else
    puts "No prompt"
    reply_message = "No se cómo procesar tu mensaje. Asegúrate de que sea un mensaje de texto."
    chat_id = body.dig("message", "chat", "id")
  end

  response = client.chat(prompt) if prompt
  puts response if response
  reply_message = response.dig("choices", 0, "message", "content") || reply_message
  puts reply_message

  return respond_request(reply_message) unless chat_id

  telegram = Clients::Telegram.new
  response = telegram.send_message(chat_id, reply_message)
  logger.info(response)
end

private

def telegram_message?(event) = event.dig("message","text") ? true : false

def api_request?(event) = event.dig("prompt") ? true : false

def respond_request(reply)
  {
    statusCode: 200,
    body: {
      message: reply,
      # location: response.body
    }.to_json
  }
end

def respond_telegram(reply, chat_id)
  {
    statusCode: 200,
    body: {
      method: "sendMessage",
      chat_id: chat_id,
      text: reply_message
    }.to_json
  }
end