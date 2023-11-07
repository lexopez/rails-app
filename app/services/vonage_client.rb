class VonageClient
    attr_reader :client

    def initialize
        @client = Vonage::Client.new(api_key: api_key, api_secret: api_secret)
    end

    def send_text(user, message)
        client.sms.send(from: 'Ruby', to: user.phone, text: message)
    end

    private

    def api_key
        ENV['VONAGE_KEY']
    end

    def api_secret
        ENV['VONAGE_SECRET']
    end
end