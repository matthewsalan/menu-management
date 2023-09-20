# README
Steps to run JSON importer

1. Pull down the repo `git clone git@github.com:matthewsalan/menu-management.git`
2. Run `bundle install`
3. *Optional*, run all specs `bin/rspec spec`
4. Start the server `bin/rails s`
5. Using cURL or Postman, run the following examples:
   
**Postman other API inspector tool**

Use your favorite API testing tool and create a sample `POST` request

`POST` body:
![Screenshot from 2023-09-20 14-51-44](https://github.com/matthewsalan/menu-management/assets/8284435/11a5de5a-86bb-4f8b-a8f2-1a27b9dc83eb)

Success response:
![Screenshot from 2023-09-20 14-52-02](https://github.com/matthewsalan/menu-management/assets/8284435/2decbc1b-b399-46f5-9d86-e7b0a4386081)

`POST` body with incorrect syntax
![Screenshot from 2023-09-20 14-52-52](https://github.com/matthewsalan/menu-management/assets/8284435/0330fae3-e3b8-423b-8e0c-f3f66d416bda)

Error response body:
![Screenshot from 2023-09-20 14-53-07](https://github.com/matthewsalan/menu-management/assets/8284435/b2958c9e-7725-4326-a66a-19b93fc10001)

**cURL**

If you prefer to use cURL, then running the follow command
```
curl --location 'http://127.0.0.1:3000/menus' \
--header 'Content-Type: application/json' \
--data '{
    "restaurants": [
        {
           "name": "Poppo'\''s Cafe",
           "menus": [
              {
                "name": "lunch",
                "menu_items": [
                  {
                    "name": "Burger",
                    "price": 9.00
                  },
                  {
                    "name": "Small Salad",
                    "price": 5.00
                  }
                ]
              },
              {
                "name": "dinner",
                "menu_items": [
                  {
                    "name": "Burger",
                    "price": 9.00
                  },
                  {
                    "name": "Small Salad",
                    "price": 5.00
                  }
                ]
              }
            ]
        }
    ]
}'
```
An error or success response body should be returned based on the request body.
