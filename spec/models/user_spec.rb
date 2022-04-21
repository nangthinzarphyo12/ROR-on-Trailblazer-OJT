require 'rails_helper'

RSpec.describe User, type: :model do

  subject{
    User.new(
      name: "John",
      email: "john@gmail.com",
      password: "123pwd",
      password_confirmation: "123pwd",
      phone: "09-965304579",
      role: 1
    )
  }

  # context 'validation tests' do
  #   it 'ensures name presence' do
  #     expect(subject).to be_valid
  #   end

  #   it "name not presence" do
  #     subject.name = nil
  #     expect(subject).to_not be_valid
  #   end

  #   it "name greater than max length" do
  #     subject.name = 'a' * 256
  #     expect(subject).to_not be_valid
  #   end

  #   it 'email presence' do
  #     expect(subject).to be_valid
  #   end

  #   it "email not presence" do
  #     subject.email = nil
  #     expect(subject).to_not be_valid
  #   end

  #   it "email greater than max length" do
  #     subject.email = 'a' * 256
  #     expect(subject).to_not be_valid
  #   end

  #   it "invalid email format" do
  #     subject.email = 'adminMail'
  #     expect(subject).to_not be_valid
  #   end

  #   it 'password presence' do
  #     expect(subject).to be_valid
  #   end

  #   it "password not presence" do
  #     subject.password = nil
  #     expect(subject).to_not be_valid
  #   end

  #   it "did not match with confirm password" do
  #     subject.password = 'changepwd'
  #     expect(subject).to_not be_valid
  #   end

  #   it "password greater than max length" do
  #     subject.password = 'a' * 256
  #     expect(subject).to_not be_valid
  #   end

  #   it "phone greater than maxlength" do
  #     subject.phone = "09-9653045762"
  #     expect(subject).to_not be_valid
  #   end

  #   it 'role presence' do
  #     expect(subject).to be_valid
  #   end

  #   it "role not presence" do
  #     subject.role = nil
  #     expect(subject).to_not be_valid
  #   end

  # end
end
