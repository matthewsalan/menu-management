class MenuItem < ApplicationRecord
  has_and_belongs_to_many :menus
  belongs_to :restaurant
  validates :price, presence: true
  validates :name, presence: true, uniqueness: true

  def add_to_menu(menu)
    menus << menu
  end
end
