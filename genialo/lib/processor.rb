require 'logger'

module Lambda
  # This class processes the event received by the Lambda function
  class Processor

    def initialize(event)
      @logger = Logger.new($stdout)
      @event = event
    end
    
    def process_event
      body = JSON.parse(@event.dig("body"))
      
      prompt, chat_id = extract_body(body)

      response = prompt ? chat_response(prompt) : "No se cómo procesar tu mensaje. Asegúrate de que sea un mensaje de texto."
      
      return respond_request(response) unless chat_id

      respond_telegram(response, chat_id)
    end

    private

    def chat_response(prompt)
      @logger.info("Chat request received with prompt: #{prompt}. Processing...")
      client = Clients::OpenAI.new
      @logger.debug("Client created: #{client.inspect}")
      response = client.chat(prompt)

      response.dig("choices", 0, "message", "content")
    end

    def extract_body(body)
      if telegram_message?(body)
        @logger.info("Telegram message received with body: #{body}. Processing...")
        prompt = body.dig("message", "text") || "Inform user that there was a problem with the request."
        chat_id = body.dig("message", "chat", "id")
        return [prompt, chat_id]
      elsif api_request?(body)
        @logger.info("API request received with body: #{body}. Processing...")
        prompt = body.dig("prompt")
        return [prompt, nil]
      else
        @logger.info("No prompt received with body: #{body}. Cannot process.")
        chat_id = body.dig("message", "chat", "id")
        return [nil, chat_id]
      end
    end

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
      telegram = Clients::Telegram.new
      telegram.send_message(chat_id, reply)
    end
  end
end
    