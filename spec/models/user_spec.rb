require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      user = User.new(name: 'User', email: 'user@gmail.com')
      expect(user.description).to eq('User - user@gmail.com')
    end
  end
end
