FactoryBot.define do
  factory :tradevan_void_allowance_data, class: Einvoice::Tradevan::Model::VoidAllowanceData do
    type { "BB05" }
    companyUn { "53086054" }
    allowanceNumber { "ICKEC20160324001" }
    allowancePaperReturned { "Y" }
    voidDate { "20160325" }
    voidTime { "10:30:00" }
    voidReason { "測試折讓" }
    remark { "測試備註" }
  end
end

