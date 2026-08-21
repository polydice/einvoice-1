module Einvoice
  module Tradevan
    module Model
      class AllowanceData < Base
        VALID_OPTIONS_KEYS = [
          :companyUn,
          :orgId,
          :orgUn,
          :type,
          :allowanceIdentifier,
          :allowanceNumber,
          :allowanceDate,
          :allowaDeclaration,
          :transactionDate,
          :transactionTime,
          :allowanceExclusiveAmount,
          :allowanceTax,
          :allowancePaperReturned,
          :allowanceInclusiveAmount,
          :receiverName,
          :receiverAddrZip,
          :receiverAddrRoad,
          :receiverEmail,
          :receiverMobile,
          :paperPrintMode,
          :invoiceAlarmMode,
          :itemList
        ].freeze

        attr_accessor *VALID_OPTIONS_KEYS

        validates :companyUn, presence: true, length: { is: 8 }
        validates :orgId, presence: true, length: { is: 5 }
        validates :orgUn, length: { is: 8 }, allow_blank: true
        validates :type, presence: true, length: { maximum: 4 }, inclusion: { in: %w(BB04 H A) }
        validates :allowanceIdentifier, presence: true, length: { maximum: 100 }, allowanceIdentifier: true
        validates :allowanceExclusiveAmount, presence: true, length: { maximum: 20 }
        validates :allowanceTax, presence: true, length: { maximum: 20 }
        validates :allowancePaperReturned, presence: true, length: { is: 1 }, inclusion: { in: %w(Y N) }
        validates :allowanceInclusiveAmount, presence: true, length: { maximum: 20 }
        validates :paperPrintMode, presence: true, length: { is: 1 }, inclusion: { in: %w(0 1 2 3 4) }
        validates :invoiceAlarmMode, presence: true, length: { is: 1 }, inclusion: { in: %w(0 1 2 3 4 5 6) }
        validates :transactionDate, presence: true, length: { is: 8 }, format: { with: /\A\d{8}\Z/ }
        validates :transactionTime, presence: true, length: { is: 8 }, format: { with: /\A\d{2}\:\d{2}\:\d{2}\Z/ }
        validates :receiverName, allow_blank: true, length: { maximum: 30 }
        validates :receiverAddrZip, allow_blank: true, length: { maximum: 5 }
        validates :receiverAddrRoad, allow_blank: true, length: { maximum: 100 }
        validates :receiverEmail, allow_blank: true, length: { maximum: 400 }
        validates :receiverMobile, allow_blank: true, length: { maximum: 15 }
        validates :itemList, presence: true, itemList: true

        # Type BB04 H
        validates :allowanceNumber, presence: true, length: { is: 16 }, allowanceNumber: true, if: proc { %w(BB04 H).include?(self.type) }
        validates :allowanceDate, presence: true, length: { is: 8 }, format: { with: /\A\d{8}\Z/ }, if: proc { %w(BB04 H).include?(self.type) }

        # Type A
        validates :allowaDeclaration, allow_blank: true, length: { is: 6 }, format: { with: /\A\d{6}\Z/ }, if: proc { self.type == 'A' }

        def payload
          serializable_hash(except: EXCLUDED_ATTRIBUTES, include: [:itemList])
        end
      end
    end
  end
end

