require 'rails_helper'

RSpec.describe 'MenuItem', type: :model do
  let(:menu) { Menu.create(name: 'brunch') }

  context 'it creates a menu item insane' do
    let(:menu_item) do
      MenuItem.create(price: 2.99, name: 'Bacon', menu_id: menu.id)
    end

    it 'creates' do
      expect { menu_item }.to change { MenuItem.count }.by 1
    end
  end

  context 'validations' do
    it 'does not create a menu item instance if price is blank' do
      expect { MenuItem.create!(menu_id: menu.id, name: 'Pancakes') }
        .to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Price can't be blank")
    end

    it 'does not create a menu item instance if not associated with a menu' do
      expect { MenuItem.create!(price: 9.99, name: 'Cinnamon roles') }
        .to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Menu must exist')
    end

    it 'does not create a menu item instance if name is blank' do
      expect { MenuItem.create!(menu_id: menu.id, price: 4.99) }
        .to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")
    end
  end
end
