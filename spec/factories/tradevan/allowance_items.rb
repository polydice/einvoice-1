FactoryBot.define do
  factory :tradevan_allowance_item, class: Einvoice::Tradevan::Model::IssueItem do
    saleIdentifier { "53086054_ICKEC_20160323014320" }
    serialNumber { "0001" }
    productCode { "98765" }
    productName { "折讓商品" }
    qty { "1" }
    price { "95" } # 折讓單使用 price
    tax { "5" }
    itemTotal { "100" }
    itemExclude { "95" }
    taxType { "T" }
  end
end

