class MenusController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @menus = []
    menu_params['restaurants'].each do |restaurant|
      @restaurant = Restaurant.find_by(name: restaurant['name']) || create_restaurant(restaurant)
      add_menu_and_items(restaurant['menus'], @restaurant)
    end
    body = json_body(@menus)
    render json: body, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.errors.full_messages }, status: :unprocessable_entity
  rescue NoMethodError
    render json: { errors: 'Invalid syntax: must be one of: restaurants, name, menus, menu_items, or price' },
           status: :unprocessable_entity
  end

  private

  def json_body(menus)
    body = { 'menus' => [] }
    menus.each do |menu|
      body['menus'] << {
        restaurant_id: menu.restaurant.id,
        name: menu.name,
        menu_items: menu.menu_items.map { |item| { name: item.name, price: item.price, id: item.id } }
      }
    end
    body
  end

  def menu_params
    params.permit(restaurants: [:name, menus: [:name, menu_items: [:name, :price]]])
  end

  def create_restaurant(restaurant)
    Restaurant.create!(name: restaurant['name'])
  end

  def add_menu_and_items(menus, restaurant)
    ActiveRecord::Base.transaction do
      menus.each do |menu|
        @menu = Menu.find_by(name: menu['name'], restaurant_id: restaurant.id) || create_menu(menu, restaurant.id)
        menu['menu_items'].each do |item|
          menu_item = MenuItem.find_by(name: item['name'], restaurant_id: restaurant.id) || create_menu_item(item, restaurant.id)
          @menu.add_menu_items(menu_item) unless @menu.menu_items.include?(menu_item)
        end
      end
    end
  end

  def create_menu(menu, restaurant_id)
    menu = Menu.create!(name: menu['name'], restaurant_id: restaurant_id)
    @menus << menu
    menu
  end

  def create_menu_item(item, restaurant_id)
    MenuItem.create!(name: item['name'], price: item['price'], restaurant_id: restaurant_id)
  end
end
