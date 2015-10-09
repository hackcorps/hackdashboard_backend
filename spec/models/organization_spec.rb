require 'rails_helper'

RSpec.describe Organization, type: :model do

  #describe 'relations' do
   # it { should have_many :project}
  #end
  describe 'validations' do
    describe 'is invalid' do
      it 'when required #name is not set' do
        expect(FactoryGirl.build :organization, name: '').not_to be_valid
      end
      it 'when length #name at less 2 characters' do
        expect(FactoryGirl.build :organization, name: 'A').not_to be_valid
      end
      it 'when length #name at greate 50 characters' do
        expect(FactoryGirl.build :organization, name: '123456789012345678901234567890123456789012345678905').not_to be_valid
      end
    end
    describe 'is valid' do
      it 'when required #name is set' do
        expect(FactoryGirl.build :organization, name: 'organization name ').to be_valid
      end
      it 'when length #name at greate 2 characters' do
        expect(FactoryGirl.build :organization, name: 'AAA').to be_valid
      end
      it 'when length #name at less 50 characters' do
        expect(FactoryGirl.build :organization, name: '12345678901234567012345678901234567890123456789').to be_valid
      end
    end
  end
end