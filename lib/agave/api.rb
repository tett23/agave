module Agave
  module API
    def connection
      Faraday::connection.new(url: Agave::Config.server) do |builder|
        builder.request :url_encoded
        builder.adapter Faraday.default_adapter
      end
    end

    def reserve
    end
  end
end
