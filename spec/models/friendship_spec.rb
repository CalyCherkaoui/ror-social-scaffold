require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'Verification of associations forein keys' do

    it 'the friendship must belongs to user as user' do
      friendship = Friendship.reflect_on_association(:user)
      expect(friendship.macro).to eq(:belongs_to)
    end


  end
end
