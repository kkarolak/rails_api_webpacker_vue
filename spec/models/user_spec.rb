require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it do
      should have_many(:comments)
    end
    it do
      should have_many(:articles)
    end
  end
  describe "validations" do
    it "validates presence of email" do
      should validate_presence_of(:email)
    end
    it "validates presence of name" do
      should validate_presence_of(:name)
    end
    it "validates presence of password_digest" do
      should validate_presence_of(:password_digest)
    end
    it "validates uniqueness of email" do
      should validate_uniqueness_of(:email)
    end
  end
end
