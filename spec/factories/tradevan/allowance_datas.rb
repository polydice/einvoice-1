FactoryBot.define do
  factory :tradevan_allowance_data, class: Einvoice::Tradevan::Model::AllowanceData do
    companyUn { "53086054" }
    orgId { "ICKEC" }
    allowanceIdentifier { "53086054_ICKEC_20160323014320" }
    transactionDate { "20160323" }
    transactionTime { "01:43:20" }
    allowanceExclusiveAmount { "95" }
    allowanceTax { "5" }
    allowancePaperReturned { "Y" }
    allowanceInclusiveAmount { "100" }
    paperPrintMode { "0" }
    invoiceAlarmMode { "0" }
    itemList { [] }

    after(:build) do |data|
      data.itemList << FactoryBot.build(:tradevan_allowance_item)
    end

    trait :BB04 do
      type { "BB04" }
      allowanceNumber { "ICKEC20160324001" }
      allowanceDate { "20160324" }
      receiverName { "Jamie Oliver" }
      receiverAddrZip { "106" }
      receiverAddrRoad { "台北市大安區新生南路一段 50 號" }
      receiverEmail { "hi@icook.tw" }
      receiverMobile { "0912123123" }
    end

    trait :H do
      type { "H" }
      allowanceNumber { "ICKEC20160324001" }
      allowanceDate { "20160324" }
      receiverName { "Jamie Oliver" }
      receiverAddrZip { "106" }
      receiverAddrRoad { "台北市大安區新生南路一段 50 號" }
      receiverEmail { "hi@icook.tw" }
      receiverMobile { "0912123123" }
    end

    trait :A do
      type { "A" }
      allowaDeclaration { "201803" }
    end
  end
end

