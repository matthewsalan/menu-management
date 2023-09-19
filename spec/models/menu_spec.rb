require 'rails_helper'

RSpec.describe 'Menu', type: :model do
  let(:restaurant) { Restaurant.create(name: 'Hampton & Hudson') }
  let(:menu) { Menu.create(name: 'brunch', restaurant_id: restaurant.id) }

  context 'it creates a menu insane' do
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

  describe '#add_menu_items' do
    let(:menu_item) { MenuItem.create(price: 2.99, name: 'Bacon', restaurant_id: restaurant.id) }

    it 'adds items to a given menu' do
      menu
      menu.add_menu_items(menu_item)
      expect(menu.menu_items.count).to eq 1
    end
  end
end
