require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context 'validation tests' do
    it 'ensures name presence' do
      user = User.create(name:'Nang Nang' , email: 'nang123@gmail.com', password: '123456').save
      
      expect(user).to eq(true)
    end
    it 'ensures email presence' do
      user = User.create(name:'Nang Nang' , email: 'nang123@gmail.com', password: '123456').save
      expect(user).to eq(true)
    end
    it 'ensures password presence' do
      user = User.create(name:'Nang Nang' , email: 'nang123@gmail.com', password: '123456').save
      expect(user).to eq(true)
    end
    it 'should save successfully' do
      user = User.new(name:'Nang Nang' , email: 'nang123@gmail.com', password: '123456').save
      expect(user).to eq(true)
    end
  end
  context 'scope tests' do
  end
end
