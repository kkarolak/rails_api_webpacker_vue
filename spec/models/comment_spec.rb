require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it "validates presence of content" do
      should validate_presence_of(:content)
    end
    it "validates length of content" do
      should validate_length_of(:content).is_at_least(1)
      should validate_length_of(:content).is_at_most(300)
    end
  end
  describe 'associations' do
    it do
      should belong_to(:article)
    end
    it do
      should belong_to(:user)
    end
  end
end
