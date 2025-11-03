module Einvoice
  module Tradevan
    module Model
      class IssueData < Base
        VALID_OPTIONS_KEYS = [
          :companyUn,
          :orgId,
          :orgUn,
          :type,
          :saleIdentifier,
          :allowanceIdentifier,
          :transactionNumber,
          :transactionDate,
          :transactionTime,
          :total,
          :transactionSource,
          :transactionTarget,
          :invoiceNumber,
          :allowanceNumber,
          :allowanceDate,
          :allowanceExclusiveAmount,
          :allowanceTax,
          :allowancePaperReturned,
          :allowanceInclusiveAmount,
          :paperPrintMode,
          :invoiceAlarmMode,
          :invoicePaperReturned,
          :donate,
          :donationUnit,
          :carrierType,
          :carrierId,
          :carrierIdHidden,
          :buyerUn,
          :buyerTitle,
          :receiverName,
          :receiverAddrZip,
          :receiverAddrRoad,
          :receiverEmail,
          :receiverMobile,
          :allowaDeclaration,
          :idViewId,
          :memberId,
          :checkNumber,
          :invoiceDate,
          :invoiceTime,
          :texclusiveAmount,
          :oexclusiveAmount,
          :zexclusiveAmount,
          :tax,
          :mainRemark,
          :invoiceType,
          :zeroTaxRateReason,
          :preDataCode,
          :customsClearanceMark,
          :itemList
        ].freeze

        attr_accessor *VALID_OPTIONS_KEYS

        validates :companyUn, presence: true, length: { is: 8 }
        validates :orgId, presence: true, length: { is: 5 }
        validates :orgUn, length: { is: 8 }, allow_blank: true
        validates :type, presence: true, length: { maximum: 4 }, inclusion: { in: %w(BA04 I G R BB04 H A) }
        validates :transactionNumber, presence: true, length: { maximum: 50 }
        validates :transactionDate, presence: true, length: { is: 8 }, format: { with: /\A\d{8}\Z/ }
        validates :transactionSource, length: { maximum: 50 } # Public Affair Firm presence: true
        validates :transactionTarget, length: { maximum: 50 } # Public Affair Firm presence: true
        validates :paperPrintMode, presence: true, length: { is: 1 }, inclusion: { in: %w(0 1 2 3 4) }
        validates :invoiceAlarmMode, presence: true, length: { is: 1 }, inclusion: { in: %w(0 1 2 3 4 5 6) }
        validates :invoicePaperReturned, presence: true, length: { maximum: 1 }, inclusion: { in: %w(Y N) }, invoicePaperReturned: true, if: proc { %w(BB04 H A).include?(self.type) || (self.buyerUn.blank? && self.paperPrintMode.to_i != 0) }
        validates :carrierType, presence: true, length: { is: 6 }, if: proc { self.paperPrintMode.to_i == 0 && self.donate == 'N' && !%w(BB04 H A).include?(self.type) }
        validates :buyerUn, length: { is: 8 }, allow_blank: true, unless: proc { %w(BB04 H A).include?(self.type) }
        validates :buyerTitle, length: { maximum: 60 }, allow_blank: true, unless: proc { %w(BB04 H A).include?(self.type) }
        validates :idViewId, allow_blank: true, length: { maximum: 10 }
        validates :memberId, allow_blank: true, length: { maximum: 50 }
        validates :itemList, presence: true, itemList: true

        # Type BA04 I R G
        validates :saleIdentifier, presence: true, length: { maximum: 100 }, saleIdentifier: true, if: proc { %w(BA04 I R G).include?(self.type) }

        # Type BB04 H A
        validates :allowanceIdentifier, presence: true, length: { maximum: 100 }, allowanceIdentifier: true, if: proc { %w(BB04 H A).include?(self.type) }
        validates :allowanceExclusiveAmount, presence: true, length: { maximum: 20 }, if: proc { %w(BB04 H A).include?(self.type) }
        validates :allowanceTax, presence: true, length: { maximum: 20 }, if: proc { %w(BB04 H A).include?(self.type) }
        validates :allowancePaperReturned, presence: true, length: { is: 1 }, inclusion: { in: %w(Y N) }, if: proc { %w(BB04 H A).include?(self.type) }
        validates :allowanceInclusiveAmount, presence: true, length: { maximum: 20 }, if: proc { %w(BB04 H A).include?(self.type) }

        # Type BA04 R G H
        validates :invoiceNumber, presence: true, length: { is: 10 }, if: proc { %w(BA04 R G H).include?(self.type) }

        # Type BB04 H
        validates :allowanceNumber, presence: true, length: { is: 16 }, allowanceNumber: true, if: proc { %w(BB04 H).include?(self.type) }
        validates :allowanceDate, presence: true, length: { is: 8 }, format: { with: /\A\d{8}\Z/ }, if: proc { %w(BB04 H).include?(self.type) }

        # Type A
        validates :allowaDeclaration, allow_blank: true, length: { is: 6 }, format: { with: /\A\d{6}\Z/ }, if: proc { self.type == 'A' }

        # Type BA04 I R G
        validates :transactionTime, presence: true, length: { is: 8 }, format: { with: /\A\d{2}\:\d{2}\:\d{2}\Z/ }, if: proc { %w(BA04 I R G).include?(self.type) }
        validates :total, presence: true, length: { maximum: 20 }, total: true, if: proc { %w(BA04 I R G).include?(self.type) }
        validates :donate, presence: true, length: { is: 1 }, if: proc { %w(BA04 I R G).include?(self.type) && self.buyerUn.blank? && self.paperPrintMode.to_i == 0 }
        validates :donationUnit, presence: true, length: { maximum: 10 }, donationUnit: true, if: proc { %w(BA04 I R G).include?(self.type) && self.donate == 'Y' }

        # Type BA04 I R G BB04 H A
        validates :receiverName, allow_blank: true, length: { maximum: 30 }, if: proc { %w(BA04 I R G BB04 H A).include?(self.type) }
        validates :receiverAddrZip, allow_blank: true, length: { maximum: 6 }, if: proc { %w(BA04 I R G BB04 H A).include?(self.type) }
        validates :receiverAddrRoad, allow_blank: true, length: { maximum: 100 }, if: proc { %w(BA04 I R G BB04 H A).include?(self.type) }
        validates :receiverEmail, allow_blank: true, length: { maximum: 400 }, if: proc { %w(BA04 I G R BB04 H A).include?(self.type) }
        validates :receiverMobile, allow_blank: true, length: { maximum: 15 }, if: proc { %w(BA04 I R G BB04 H A).include?(self.type) }
        validates :carrierId, allow_blank: true, length: { maximum: 400 }, if: proc { %w(BA04 I R G).include?(self.type) }
        validates :carrierIdHidden, allow_blank: true, length: { maximum: 400 }, if: proc { %w(BA04 I R G).include?(self.type) }

        # Type BA04 I G
        validates :tax, allow_blank: true, length: { maximum: 27 }, if: proc { %w(BA04 I G).include?(self.type) }

        # Type BA04 G
        validates :checkNumber, allow_blank: true, length: { is: 4 }, if: proc { %w(BA04 G).include?(self.type) }
        validates :invoiceDate, allow_blank: true, length: { is: 8 }, if: proc { %w(BA04 G).include?(self.type) }
        validates :invoiceTime, allow_blank: true, length: { is: 8 }, if: proc { %w(BA04 G).include?(self.type) }
        validates :texclusiveAmount, allow_blank: true, length: { maximum: 27 }, if: proc { %w(BA04 I G).include?(self.type) }
        validates :oexclusiveAmount, allow_blank: true, length: { maximum: 27 }, if: proc { %w(BA04 I G).include?(self.type) }
        validates :zexclusiveAmount, allow_blank: true, length: { maximum: 27 }, if: proc { %w(BA04 I G).include?(self.type) }
        validates :mainRemark, allow_blank: true, length: { maximum: 300 }, if: proc { %w(BA04 I G).include?(self.type) }
        validates :invoiceType, allow_blank: true, length: { is: 2 }, inclusion: { in: %w(07 08) }, if: proc { %w(BA04 I G).include?(self.type) }

        # v3.0 新增欄位
        validates :zeroTaxRateReason, presence: true, length: { is: 2 }, inclusion: { in: %w[71 72 73 74 75 76 77 78 79] }, if: -> { has_zero_tax_rate_items? }
        validates :customsClearanceMark, presence: true, length: { is: 1 }, inclusion: { in: %w[1 2] }, if: -> { has_zero_tax_rate_items? }
        validates :preDataCode, allow_blank: true, length: { maximum: 10 }, if: proc { %w(BA04 G).include?(self.type) }

        def payload
          serializable_hash(except: [:errors, :validation_context], include: [:itemList])
        end

        private

        def has_zero_tax_rate_items?
          itemList&.any? { |item| item.taxType == 'Z' }
        end
      end
    end
  end
end
