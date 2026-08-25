require "faraday_middleware"
require "faraday/response/decode_tradevan"

module Einvoice
  module Connection
    # 關貿的 API 一律以 form-urlencoded 傳遞參數。provider 把參數放在 query
    # string、POST 不帶 body，body 為 nil 時 Faraday 的 url_encoded middleware
    # 不會設 Content-Type。
    #
    # net-http 0.6.0（Ruby 3.4 及之前）有 supply_default_content_type，送出前
    # 會補上這個值；net-http 0.9.1（Ruby 4.0）移除了該方法，於是關貿收到沒有
    # Content-Type 的 POST 並回 HTTP 500 與 HTML 錯誤頁。明確帶上不依賴
    # net-http 的版本行為。
    CONTENT_TYPE = 'application/x-www-form-urlencoded'.freeze

    private

    def connection(options = {})
      connection_options = {
        headers: {
          "Accept" => "application/#{format}; charset=utf-8",
          "Content-Type" => CONTENT_TYPE
        },
        url: endpoint
      }.merge(options)

      ::Faraday::Connection.new(connection_options) do |connection|
        case self.class.to_s
        when "Einvoice::Tradevan::Provider"
          connection.response :decode_tradevan, encryption_keys[:key1]
        end
        connection.request :url_encoded

        case format.to_s.downcase
        when "xml" then connection.response :xml
        when "json" then connection.response :json
        end

        connection.adapter Faraday.default_adapter
      end
    end
  end
end
