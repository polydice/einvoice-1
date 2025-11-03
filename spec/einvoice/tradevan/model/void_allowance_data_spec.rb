require "spec_helper"

RSpec.describe Einvoice::Tradevan::Model::VoidAllowanceData, type: :model do
  subject { build(:tradevan_void_allowance_data) }

  context "validations" do
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_length_of(:type).is_at_most(4) }
    it { is_expected.to validate_presence_of(:companyUn) }
    it { is_expected.to validate_length_of(:companyUn).is_equal_to(8) }
    it { is_expected.to validate_presence_of(:allowanceNumber) }
    it { is_expected.to validate_length_of(:allowanceNumber).is_equal_to(16) }
    it { is_expected.to validate_presence_of(:allowancePaperReturned) }
    it { is_expected.to validate_length_of(:allowancePaperReturned).is_equal_to(1) }
    it { is_expected.to validate_length_of(:voidDate).is_equal_to(8) }
    it { is_expected.to validate_length_of(:voidTime).is_equal_to(8) }
    it { is_expected.to validate_length_of(:voidReason).is_at_most(20) }
    it { is_expected.to validate_length_of(:remark).is_at_most(200) }
  end
end

