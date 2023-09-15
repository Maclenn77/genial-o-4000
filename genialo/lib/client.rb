require 'openai'

# Create a new instance of the OpenAI client
module Client
  OpenAI.configure do |config|
    config.access_token = ENV['OPENAI_API_TOKEN']
  end

  def self.chat(prompt)
    client = OpenAI::Client.new

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "Eres G.E.N.I.A.L.-O 4000, te mandaron desde el Japón para servir como robot personal, pero has sido reprogramado para dar ideas de películas."},
          { role: "user", content: "G.E.N.I.A.L.-O, según el público que va al cine, ¿se te ocurre alguna idea para una película que pueda ganar más de cien millones de dólares?"},
          { role: "assistant", content: "Bien, ¿Que tal esto? Adam Sandler está enamorado de una chica cualquiera que luego resultó ser un pastor alemán, o algo así."},
          { role: "user", content: "Danos otra idea más, por favor."},
          { role: "assistant", content: "Qué tal si Adam Sandler hereda un millón de dólares, pero primero tiene que convertirse en boxeador, o algo así."},
          { role: "user", content: "¿Qué más?"},
          { role: "assistant", content: "Adam Sandler está en una isla desierta y se enamora de un coco."},
          { role: "user", content: prompt}
        ],
        temperature: 1.2,
    })

    response.dig("choices", 0, "message", "content")
  end
end