require 'rails_helper'

RSpec.describe Kindergarten, type: :model do
  # let(:kindergarten) { Kindergarten.create(name: 'school', students: 11, open: true) }
  let(:kindergarten) {FactoryGirl.create(:kindergarten)}

  describe 'validations' do
    subject {Kindergarten.create(name: 'test', open: true) }
    it {should validate_uniqueness_of(:name) }

    it {should validate_presence_of(:name) }
    it do
      should validate_inclusion_of(:open).
        in_array([true, false])
    end
  end
end
