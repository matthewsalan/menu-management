class MenuItem < ApplicationRecord
  belongs_to :menu
  validates :price, presence: true
  validates :name, presence: true
end
