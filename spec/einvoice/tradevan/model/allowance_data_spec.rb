require "spec_helper"

RSpec.describe Einvoice::Tradevan::Model::AllowanceData, type: :model do
  subject { build(:tradevan_allowance_data, :BB04) }

  context "validations" do
    it { is_expected.to validate_presence_of(:companyUn) }
    it { is_expected.to validate_length_of(:companyUn).is_equal_to(8) }
    it { is_expected.to validate_presence_of(:orgId) }
    it { is_expected.to validate_length_of(:orgId).is_equal_to(5) }
    it { is_expected.to validate_length_of(:orgUn).is_equal_to(8) }
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_length_of(:type).is_at_most(4) }
    it { is_expected.to validate_presence_of(:allowanceIdentifier) }
    it { is_expected.to validate_length_of(:allowanceIdentifier).is_at_most(100) }
    it { is_expected.to validate_presence_of(:allowanceExclusiveAmount) }
    it { is_expected.to validate_length_of(:allowanceExclusiveAmount).is_at_most(20) }
    it { is_expected.to validate_presence_of(:allowanceTax) }
    it { is_expected.to validate_length_of(:allowanceTax).is_at_most(20) }
    it { is_expected.to validate_presence_of(:allowancePaperReturned) }
    it { is_expected.to validate_length_of(:allowancePaperReturned).is_equal_to(1) }
    it { is_expected.to validate_presence_of(:allowanceInclusiveAmount) }
    it { is_expected.to validate_length_of(:allowanceInclusiveAmount).is_at_most(20) }
    it { is_expected.to validate_presence_of(:paperPrintMode) }
    it { is_expected.to validate_length_of(:paperPrintMode).is_equal_to(1) }
    it { is_expected.to validate_presence_of(:invoiceAlarmMode) }
    it { is_expected.to validate_length_of(:invoiceAlarmMode).is_equal_to(1) }
    it { is_expected.to validate_presence_of(:transactionDate) }
    it { is_expected.to validate_length_of(:transactionDate).is_equal_to(8) }
    it { is_expected.to validate_presence_of(:transactionTime) }
    it { is_expected.to validate_length_of(:transactionTime).is_equal_to(8) }
    it { is_expected.to validate_length_of(:receiverName).is_at_most(30) }
    it { is_expected.to validate_length_of(:receiverAddrZip).is_at_most(5) }
    it { is_expected.to validate_length_of(:receiverAddrRoad).is_at_most(100) }
    it { is_expected.to validate_length_of(:receiverEmail).is_at_most(400) }
    it { is_expected.to validate_length_of(:receiverMobile).is_at_most(15) }
    # itemList 驗證由自定義 validator 處理
    it "validates presence of itemList" do
      subject.itemList = []
      expect(subject).not_to be_valid
      expect(subject.errors[:itemList]).to be_present
    end

    context "on type BB04" do
      subject { build(:tradevan_allowance_data, :BB04) }

      it { is_expected.to validate_presence_of(:allowanceNumber) }
      it { is_expected.to validate_length_of(:allowanceNumber).is_equal_to(16) }
      it { is_expected.to validate_presence_of(:allowanceDate) }
      it { is_expected.to validate_length_of(:allowanceDate).is_equal_to(8) }
    end

    context "on type H" do
      subject { build(:tradevan_allowance_data, :H) }

      it { is_expected.to validate_presence_of(:allowanceNumber) }
      it { is_expected.to validate_length_of(:allowanceNumber).is_equal_to(16) }
      it { is_expected.to validate_presence_of(:allowanceDate) }
      it { is_expected.to validate_length_of(:allowanceDate).is_equal_to(8) }
    end

    context "on type A" do
      subject { build(:tradevan_allowance_data, :A) }

      it { is_expected.to validate_length_of(:allowaDeclaration).is_equal_to(6) }
    end
  end
end

