require "active_model"

require "einvoice/tradevan/validator/issue_data_validator"

module Einvoice
  module Tradevan
    module Model
      class Base
        include ActiveModel::Model
        include ActiveModel::Validations
        include ActiveModel::Serialization
        include ActiveModel::Serializers::JSON

        include Einvoice::Tradevan::Validator

        # attributes 以 instance_values 實作，因此 ActiveModel 的內部狀態也會被
        # 當成欄位。這些不屬於關貿 API 的 payload，序列化前必須排除 —— 關貿收到
        # 未知欄位會拒絕整筆請求。
        #
        # validation_context 是 Rails 7.2 及之前存放驗證 context 的 ivar 名稱，
        # context_for_validation 是 Rails 8.0 起的名稱（值為 ActiveModel::
        # ValidationContext 物件）。兩者並列以同時支援這些 Rails 版本。
        EXCLUDED_ATTRIBUTES = %i[errors validation_context context_for_validation].freeze

        def attributes=(hash)
          @itemList ||= []
          hash.each do |key, value|
            case key.to_sym
            when :itemList
              value.each { |v| @itemList << IssueItem.new(v) }
            else
              send("#{key}=", value)
            end
          end
        end

        def attributes
          instance_values
        end
      end
    end
  end
end
