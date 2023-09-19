require 'rails_helper'

RSpec.describe 'Menu', type: :model do
  let(:restaurant) { Restaurant.create(name: 'Hampton & Hudson') }

  context 'it creates a menu insane' do
    let(:menu) { Menu.create(name: 'brunch', restaurant_id: restaurant.id) }

    it 'creates' do
      expect { menu }.to change { Menu.count }.by 1
    end
  end

  context 'validations' do
    it 'does not create a menu instance if category is blank' do
      expect { Menu.create }.not_to change(Menu, :count)
      expect { Menu.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
