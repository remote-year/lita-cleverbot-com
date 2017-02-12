module Lita
  module Handlers
    class CleverbotCom < Handler
      CONVERSATION_HASH_KEY = 'conversation_hash'

      on :unhandled_message, :say_something_clever
      config :api_key, type: String

      def say_something_clever(payload)
        if command?(payload)
          response = clever_api_request(payload)
          set_conversation_state(payload, response)
          payload_message(payload).reply(response['output'])
        end
      end

      private

      def command?(payload)
        payload_message(payload).command?
      end

      def clever_api_request(payload)
        conn = Faraday.new(:url => 'https://www.cleverbot.com') do |faraday|
          faraday.request  :url_encoded             # form-encode POST params
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
        response = conn.get do |req|
          req.url '/getreply'
          req.params[:key] = config.api_key
          req.params[:input] = message_body(payload)
          cs = conversation_state(payload)
          req.params[:cs] = cs['cs'] if cs['cs']
        end
        JSON.parse(response.body)
      end

      def user_key(payload)
         payload_message(payload).user.id
      end

      def room_key(payload)
        payload_message(payload).source.room
      end

      def message_body(payload)
        payload_message(payload).body
      end

      def conversation_key(payload)
        "converstaion_key:user_key:#{user_key(payload)}|room_key:#{room_key(payload)}"
      end

      def set_conversation_state(payload, conversation_response)
        redis.hset(CONVERSATION_HASH_KEY, conversation_key(payload), conversation_response.to_json)
      end

      def conversation_state(payload)
        s = redis.hget(CONVERSATION_HASH_KEY, conversation_key(payload))
        JSON.parse(s) if s
      end

      def payload_message(payload)
        payload[:message]
      end

      Lita.register_handler(self)
    end
  end
end
