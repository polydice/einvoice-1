require "spec_helper"

RSpec.describe Einvoice::Tradevan::Model::IssueItem, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:saleIdentifier) }
    it { is_expected.to validate_length_of(:saleIdentifier).is_at_most(100) }
    it { is_expected.to validate_presence_of(:serialNumber) }
    it { is_expected.to validate_length_of(:serialNumber).is_equal_to(4) }
    it { is_expected.to validate_length_of(:invoiceNumber).is_equal_to(10) }
    it { is_expected.to validate_length_of(:invoiceDate).is_equal_to(8) }
    it { is_expected.to validate_length_of(:invoiceTime).is_equal_to(8) }
    it { is_expected.to validate_length_of(:productCode).is_at_most(30) }
    it { is_expected.to validate_presence_of(:productName) }
    it { is_expected.to validate_length_of(:productName).is_at_most(500) }
    it { is_expected.to validate_presence_of(:qty) }
    it { is_expected.to validate_length_of(:qty).is_at_most(27) }
    it { is_expected.to validate_length_of(:price).is_at_most(27) } # 折讓單使用
    it { is_expected.to validate_length_of(:priceExclude).is_at_most(27) } # 發票使用
    it { is_expected.to validate_length_of(:priceInclude).is_at_most(27) } # 發票使用
    it { is_expected.to validate_length_of(:tax).is_at_most(27) }
    it { is_expected.to validate_length_of(:itemExclude).is_at_most(27) }
    it { is_expected.to validate_length_of(:itemTotal).is_at_most(27) }
    # it { is_expected.to validate_length_of(:taxType).is_equal_to(1) }
    it { is_expected.to validate_length_of(:description).is_at_most(300) }

    context "v3.0 價格欄位驗證" do
      context "發票項目" do
        subject { build(:tradevan_issue_item, priceExclude: "95", priceInclude: "100", price: nil) }

        it "必須同時有 priceExclude 和 priceInclude" do
          subject.priceExclude = nil
          subject.priceInclude = "100"
          expect(subject).not_to be_valid
          expect(subject.errors[:priceExclude]).to be_present

          subject.priceExclude = "95"
          subject.priceInclude = nil
          expect(subject).not_to be_valid
          expect(subject.errors[:priceInclude]).to be_present
        end

        it "有 priceExclude 和 priceInclude 時應該有效" do
          subject.priceExclude = "95"
          subject.priceInclude = "100"
          expect(subject).to be_valid
        end
      end

      context "折讓單項目" do
        subject { build(:tradevan_allowance_item, price: "95", priceExclude: nil, priceInclude: nil) }

        it "必須有 price" do
          subject.price = nil
          expect(subject).not_to be_valid
        end

        it "有 price 時應該有效" do
          subject.price = "95"
          expect(subject).to be_valid
        end
      end
    end
  end
end
