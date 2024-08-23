### Schema

  <img src="Screenshot 2024-08-22 at 8.20.24 PM.png" alt="drawing" width="600" style="transform:translateX(calc(60vw - 80%));"/>

## Summary

This project involves creating a Rails API for a Tea Subscription Service, designed to manage customer subscriptions efficiently. The API will include the following key features:

Subscription Management:
- Subscribe a Customer: An endpoint to subscribe a customer to a tea subscription, allowing them to receive regular tea deliveries.

- Cancel Subscription: An endpoint to cancel a customer’s tea subscription, ensuring they can opt out of the service as needed.

- View Subscriptions: An endpoint to view all of a customer's subscriptions, both active and canceled, providing a comprehensive overview of their subscription history.

Additional Considerations:
- The project focuses on achieving a Minimum Viable Product (MVP) with a clear and user-friendly API, making it easy for Frontend Developers to integrate. Additional endpoints and features can be included based on further requirements, but the emphasis is on simplicity and functionality.

## Development setup

This project uses Ruby on Rails 7.1.3 


First, clone the repository to your computer

```sh
git clone 
```

Next, install all of the Gems

```sh
bundle install
```

Create the necessary databases -

```sh
rails db:{drop,create,migrate,seed}
```


Finally, start the development server

```sh
rails s
```


### Endpoints

<details>
<summary> New Customer Tea Subscription</summary>

Request
```http
POST /api/v1/customers/1/subscriptions
```

Body
```JSON
{
  "teas": [1, 2],
  "title": "Tea Subscriptions",
  "price": 20,
  "frequency": "monthly",
  "status": "active"
}
```

Response
```JSON
{
    "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
            "title": "Tea Subscription",
            "price": 20.0,
            "status": "active",
            "frequency": "monthly"
        },
        "relationships": {
            "teas": {
                "data": [
                    {
                        "id": "1",
                        "type": "tea"
                    },
                    {
                        "id": "2",
                        "type": "tea"
                    }
                ]
            }
        }
    }
}
```

</details>

<details>
<summary> Cancels The Customer Tea Subscription</summary>

Request
```http
PATCH /api/v1/customers/1/subscriptions/1
```

Body
```JSON
{
  "status": "cancelled"
}
```

Response
```JSON
{
    "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
            "title": "Tea Subscription",
            "price": 20.0,
            "status": "cancelled",
            "frequency": "monthly"
        },
        "relationships": {
            "teas": {
                "data": [
                    {
                        "id": "1",
                        "type": "tea"
                    },
                    {
                        "id": "2",
                        "type": "tea"
                    }
                ]
            }
        }
    }
}
```

</details>

<details>
<summary> All Customer's Tea Subscriptions</summary>

Request
```http
GET /api/v1/customers/1/subscriptions
```

Response
```JSON
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "title": "Tea Subscription",
                "price": 20.0,
                "status": "cancelled",
                "frequency": "monthly"
            },
            "relationships": {
                "teas": {
                    "data": [
                        {
                            "id": "1",
                            "type": "tea"
                        },
                        {
                            "id": "2",
                            "type": "tea"
                        }
                    ]
                }
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "title": "Tea Subscription",
                "price": 20.0,
                "status": "active",
                "frequency": "monthly"
            },
            "relationships": {
                "teas": {
                    "data": [
                        {
                            "id": "1",
                            "type": "tea"
                        },
                        {
                            "id": "2",
                            "type": "tea"
                        }
                    ]
                }
            }
        }
    ]
}
```

