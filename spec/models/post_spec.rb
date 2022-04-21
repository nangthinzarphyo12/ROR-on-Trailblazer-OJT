require 'rails_helper'

RSpec.describe Post, type: :model do

  # subject{
  #   Post.new(
  #       title: "post title1",
  #       description: "this is about post1",
  #       public_flag: 1,
  #       created_by: 3
  #   )
  # }

  # context 'validation tests' do
  #   it 'ensures title presence' do
  #     expect(subject).to be_valid
  #   end

  #   it "title not presence" do
  #     subject.title = nil
  #     expect(subject).to_not be_valid
  #   end

  #   it "title greater than max length" do
  #     subject.title = 'a' * 256
  #     expect(subject).to_not be_valid
  #   end

  #   it 'description presence' do
  #     expect(subject).to be_valid
  #   end

  #   it "description not presence" do
  #     subject.description = nil
  #     expect(subject).to_not be_valid
  #   end

  #   it "description greater than max length" do
  #     subject.description = 'a' * 1001
  #     expect(subject).to_not be_valid
  #   end

  #   it 'public_flag presence' do
  #     expect(subject).to be_valid
  #   end

  #   it "public_flag not presence" do
  #     subject.public_flag = nil
  #     expect(subject).to_not be_valid
  #   end

  #   it "created_by not presence" do
  #       subject.created_by = nil
  #       expect(subject).to_not be_valid
  #   end

  # end
end
