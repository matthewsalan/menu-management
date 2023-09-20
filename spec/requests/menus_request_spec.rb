require 'rails_helper'

RSpec.describe MenusController, type: :request do
  describe 'create' do

    context 'valid json' do
      params = {
        "restaurants": [
          {
            "name": "Poppo's Cafe",
            "menus": [
              {
                "name": 'lunch',
                "menu_items": [
                  {
                    "name": 'Burger',
                    "price": 9.00
                  },
                  {
                    "name": 'Small Salad',
                    "price": 5.00
                  }
                ]
              }
            ]
          }
        ]
      }
      it 'create a new menu with related items and restaurant' do
        post '/menus', params: params, as: :json

        expect(response.status).to eq 201
        expect(Restaurant.count).to eq 1
        expect(Menu.count).to eq 1
        expect(MenuItem.count).to eq 2
      end

      it 'has a response body with newly created menu items' do
        post '/menus', params: params, as: :json

        expect(JSON.parse(response.body)).to eq(
          "menus" => [
            {
              "menu_items" => [{"id"=> MenuItem.first.id, "name" => "Burger", "price" => "9.0"},
              {"id" => MenuItem.last.id, "name" => "Small Salad", "price" => "5.0"}],
              "name" => "lunch", "restaurant_id" => Restaurant.first.id
            }
          ]
        )
      end
    end

    context 'invalid json' do
      params = {
        "restaurants": [
          {
            "name": "Poppo's Cafe",
            "menus": [
              {
                "name": 'lunch',
                "dishes": [
                  {
                    "name": 'Burger',
                    "price": 9.00
                  },
                  {
                    "name": 'Small Salad',
                    "price": 5.00
                  }
                ]
              }
            ]
          }
        ]
      }
      it 'create a new menu with related items and restaurant' do
        post '/menus', params: params, as: :json

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['errors']).to eq 'Invalid syntax: must be one of: restaurants, name, menus, menu_items, or price'
      end
    end

    context 'duplicate menu data' do
      params = {
        "restaurants": [
          {
            "name": "Poppo's Cafe",
            "menus": [
              {
                "name": 'lunch',
                "menu_items": [
                  {
                    "name": 'Burger',
                    "price": 9.00
                  },
                  {
                    "name": 'Small Salad',
                    "price": 5.00
                  }
                ]
              },
              {
                "name": 'lunch',
                "menu_items": [
                  {
                    "name": 'Burger',
                    "price": 9.00
                  },
                  {
                    "name": 'Small Salad',
                    "price": 5.00
                  }
                ]
              }
            ]
          }
        ]
      }
      it 'creates only one new menu with related items and restaurant' do
        post '/menus', params: params, as: :json

        expect(response.status).to eq 201
        expect(Restaurant.count).to eq 1
        expect(Menu.count).to eq 1
        expect(MenuItem.count).to eq 2
      end
    end
  end
end
