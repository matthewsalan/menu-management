require 'rails_helper'

RSpec.describe 'Restaurant', type: :model do
  context 'it creates a restaurant insane' do
    let(:restaurant) { Restaurant.create(name: "Jersey Mike's") }

    it 'creates' do
      expect { restaurant }.to change { Restaurant.count }.by 1
    end
  end

  context 'validations' do
    it 'does not create a restaurant instance if name is blank' do
      expect { Restaurant.create }.not_to change(Restaurant, :count)
      expect { Restaurant.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
