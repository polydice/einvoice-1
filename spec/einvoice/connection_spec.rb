require "spec_helper"

# provider 把參數放在 query string、POST 不帶 body，因此 Faraday 的 url_encoded
# middleware 不會設 Content-Type。net-http 0.6.0 會在送出前補上預設值，0.9.1
# （Ruby 4.0）移除了那段邏輯，關貿於是收到沒有 Content-Type 的 POST 並回 HTTP 500
# 與 HTML 錯誤頁。
#
# 斷言 request header 而非回應：既有的 VCR 測試比對 method / host / path，不會
# 察覺 header 少了什麼，所以這個缺陷在測試全綠的情況下也能溜到正式環境。
RSpec.describe Einvoice::Connection do
  let(:provider) do
    Einvoice::Tradevan::Provider.new(
      endpoint: "https://eci.example.com",
      client_id: "id",
      client_secret: "secret",
      encryption_keys: { key1: "0123456789abcdef", key2: "0123456789abcdef" },
      format: :json
    )
  end

  def captured_headers(connection, method)
    headers = nil
    connection.builder.insert(0, Class.new(Faraday::Middleware) do
      define_method(:call) do |env|
        headers = env.request_headers.dup
        Faraday::Response.new(status: 200, body: {})
      end
    end)
    connection.public_send(method) { |request| request.url("https://eci.example.com/probe", v: "x") }
    headers
  end

  it "declares the form-urlencoded content type" do
    expect(provider.send(:connection).headers["Content-Type"])
      .to eq("application/x-www-form-urlencoded")
  end

  it "keeps the content type on a POST that carries no body" do
    expect(captured_headers(provider.send(:connection), :post)["Content-Type"])
      .to eq("application/x-www-form-urlencoded")
  end

  it "still declares what it accepts" do
    expect(provider.send(:connection).headers["Accept"])
      .to eq("application/json; charset=utf-8")
  end

  it "lets the caller override the headers" do
    connection = provider.send(:connection, headers: { "Content-Type" => "multipart/form-data" })

    expect(connection.headers["Content-Type"]).to eq("multipart/form-data")
  end
end
