require 'rails_helper'

RSpec.describe 'MenuItem', type: :model do
  let(:restaurant) { Restaurant.create(name: 'Hampton & Hudson') }
  let(:menu) { Menu.create(name: 'brunch', restaurant_id: restaurant.id) }

  context 'it creates a menu item insane' do
    let(:menu_item) do
      MenuItem.create(price: 2.99, name: 'Bacon', restaurant_id: restaurant.id)
    end

    it 'creates' do
      expect { menu_item }.to change { MenuItem.count }.by 1
    end
  end

  context 'validations' do
    let(:menu_item) { MenuItem.create(price: 9.99, name: 'Cinnamon roles', restaurant_id: restaurant.id) }

    it 'does not create a menu item instance if price is blank' do
      expect { MenuItem.create!(name: 'Pancakes', restaurant_id: restaurant.id) }
        .to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Price can't be blank")
    end

    it 'does not create a menu item instance if there is a duplicate' do
      menu_item
      expect { MenuItem.create!(price: 9.99, name: 'Cinnamon roles', restaurant_id: restaurant.id) }
        .to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Name has already been taken')
    end

    it 'does not create a menu item instance if name is blank' do
      expect { MenuItem.create!(price: 4.99, restaurant_id: restaurant.id) }
        .to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")
    end
  end
end
