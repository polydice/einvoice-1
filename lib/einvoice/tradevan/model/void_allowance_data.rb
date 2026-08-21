module Einvoice
  module Tradevan
    module Model
      class VoidAllowanceData < Base
        VALID_OPTIONS_KEYS = [
          :type,
          :companyUn,
          :allowanceNumber,
          :allowancePaperReturned,
          :voidDate,
          :voidTime,
          :voidReason,
          :remark
        ].freeze

        attr_accessor *VALID_OPTIONS_KEYS

        validates :type, presence: true, length: { maximum: 4 }, inclusion: { in: %w(BB05 A) }
        validates :companyUn, presence: true, length: { is: 8 }
        validates :allowanceNumber, presence: true, length: { is: 16 }
        validates :allowancePaperReturned, presence: true, length: { is: 1 }, inclusion: { in: %w(Y N) }
        validates :voidDate, allow_blank: true, length: { is: 8 }, format: { with: /\A\d{8}\Z/ }
        validates :voidTime, allow_blank: true, length: { is: 8 }, format: { with: /\A\d{2}\:\d{2}\:\d{2}\Z/ }
        validates :voidReason, allow_blank: true, length: { maximum: 20 }
        validates :remark, allow_blank: true, length: { maximum: 200 }

        def payload
          serializable_hash(except: EXCLUDED_ATTRIBUTES + [:itemList])
        end
      end
    end
  end
end

