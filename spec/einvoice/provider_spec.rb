require "spec_helper"

RSpec.describe Einvoice::Provider do
  before do
    @keys = Einvoice::Configuration::VALID_OPTIONS_KEYS
  end

  context "with module configuration" do
    before do
      Einvoice.configure do |config|
        @keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      Einvoice.reset
    end

    it "inherits module configuration" do
      provider = Einvoice::Provider.new
      @keys.each do |key|
        expect(provider.send(key)).to eq key
      end
    end

    context "with class configuration" do
      before do
        @configuration = {
          client_id: '9999',
          client_secret: '9999',
          endpoint: 'http://test.com/',
          endpoint_url: 'http://test.com/action',
          encryption_keys: { key1: "key1", key2: "key2" },
          format: :xml,
        }
      end

      context "during initialization" do
        it "overrides module configuration" do
          provider = Einvoice::Provider.new(@configuration)
          @keys.each do |key|
            expect(provider.send(key)).to eq @configuration[key]
          end
        end
      end

      context "after initilization" do
        let(:provider) { Einvoice::Provider.new }

        before do
          @configuration.each do |key, value|
            provider.send("#{key}=", value)
          end
        end

        it "overrides module configuration after initialization" do
          @keys.each do |key|
            expect(provider.send(key)).to eq @configuration[key]
          end
        end
      end
    end
  end

  describe "#config" do
    subject { Einvoice::Provider.new }

    let(:config) do
      c = {}; @keys.each {|key| c[key] = key }; c
    end

    it "returns a hash representing the configuration" do
      @keys.each do |key|
        subject.send("#{key}=", key)
      end
      expect(subject.config).to eq config
    end
  end
end
