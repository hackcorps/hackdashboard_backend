require 'rails_helper'

RSpec.describe Organization, type: :model do

  describe 'relations' do
    it { should have_many :project}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_least(2).is_at_most(50) }

    it 'requires title to be set' do
      expect(FactoryGirl.build :organization, name: ' ').not_to be_valid
    end


  end

end
