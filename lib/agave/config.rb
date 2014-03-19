module Agave
  module Config
    extend self

    def server
      config[:server]
    end

    def port
      config[:port]
    end

    def host
      "http://#{server}:#{port}"
    end

    private
    def config
      YAML.load_file('config/url.yaml').symbolize_keys
    end
  end
end
