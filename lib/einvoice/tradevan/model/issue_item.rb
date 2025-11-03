module Einvoice
  module Tradevan
    module Model
      class IssueItem < Base
        VALID_OPTIONS_KEYS = [
          :saleIdentifier, # Same as invoice.saleIdentifier
          :serialNumber,
          :invoiceNumber,
          :invoiceDate,
          :invoiceTime,
          :productCode,
          :productName,
          :qty,
          :price, # 折讓單使用 (v3.0)
          :priceExclude, # 發票使用 (v3.0)
          :priceInclude, # 發票使用 (v3.0)
          :tax,
          :itemExclude,
          :itemTotal,
          :taxType,
          :description
        ]

        attr_accessor *VALID_OPTIONS_KEYS

        validates :saleIdentifier, presence: true, length: { maximum: 100 }
        validates :serialNumber, presence: true, length: { is: 4 }, numericality: true
        validates :invoiceNumber, allow_blank: true, length: { is: 10 }
        validates :invoiceDate, allow_blank: true, length: { is: 8 }, numericality: true
        validates :invoiceTime, allow_blank: true, length: { is: 8 }, format: { with: /\Ad{2}\:\d{2}\:\d{2}\Z/ }
        validates :productCode, allow_blank: true, length: { maximum: 30 }
        validates :productName, presence: true, length: { maximum: 500 }
        validates :qty, presence: true, length: { maximum: 27 }
        validates :price, allow_blank: true, length: { maximum: 27 } # 折讓單使用
        validates :priceExclude, allow_blank: true, length: { maximum: 27 } # 發票使用
        validates :priceInclude, allow_blank: true, length: { maximum: 27 } # 發票使用
        validate :validate_price_fields
        validates :tax, allow_blank: true, length: { maximum: 27 }
        validates :itemExclude, allow_blank: true, length: { maximum: 27 }
        validates :itemTotal, allow_blank: true, length: { maximum: 27 }
        validates :taxType, allow_blank: true, length: { is: 1 }, inclusion: { in: %w(T O Z) }
        validates :description, allow_blank: true, length: { maximum: 300 }

        private

        def validate_price_fields
          # 發票必須使用 priceExclude 和 priceInclude
          # 折讓單可以使用 price
          if priceExclude.present? || priceInclude.present?
            errors.add(:priceExclude, '不能為空（發票必須提供 priceExclude 和 priceInclude）') if priceExclude.blank?
            errors.add(:priceInclude, '不能為空（發票必須提供 priceExclude 和 priceInclude）') if priceInclude.blank?
          elsif price.blank?
            errors.add(:base, '必須提供 price（折讓單）或 priceExclude/priceInclude（發票）')
          end
        end
      end
    end
  end
end
