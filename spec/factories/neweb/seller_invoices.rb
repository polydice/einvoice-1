FactoryGirl.define do
  factory :neweb_seller_invoice, class: Einvoice::Neweb::Model::SellerInvoice do
    sequence :invoice_number do |n|
      "invoice_number#{n}"
    end
    invoice_date "2015/12/31"
    seller_id "53086054"
    buyer_name "Polydice, Inc."
    buyer_id "0000000000"
    invoice_type "07"
    donate_mark "0"
    print_mark "N"
    sales_amount "1000"
    free_tax_sales_amount "0"
    zero_tax_sales_amount "0"
    tax_type "1"
    tax_rate "0.05"
    tax_amount "50"
    total_amount "1050"

    random_number "AAAA"

    FactoryGirl.build(:invoice_item_neweb)
    FactoryGirl.build(:contact_neweb)
  end
end
