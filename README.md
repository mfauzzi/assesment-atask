# README

# Internal Wallet Transactional System API

This is an internal API for managing wallet transactions between different entities such as Users, Teams, and Stocks. The API allows for creating wallets, performing credit and debit transactions, and managing wallet balances using Ruby on Rails and MongoDB.

## Technologies Used

- Ruby on Rails
- MongoDB
- Postman for API testing

## Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/mfauzzi/assesment-atask.git

2. **Install dependencies**:

   ```bash
   bundle install

3. **Set up MongoDB**:

   ```bash
   sudo apt install mongodb
   sudo service mongodb start

4. **Database Configuration:**:

   - config/mongoid.yml
  
5. **Run the Server**:

   ```bash
   rails server / rails s

## API Endpoint Postman

1. **Authentication**
   - POST {base_url}/sessions: Sign in a user.
   - Header:
      - Content-Type: application/json
   - Request body:
     ```json
     {
          "email": "admin@gmail.com",
          "password": "password123"
      }
   - Response:
   ```json
   {
       "token": "your_jwt_token"
   }

2. **Wallet Management**
   - POST {base_url}/wallets: Create a new wallet for a user/team/stock.
   - Header:
      - Authorization: jwt token
      - Content-Type: application/json
   - Request body:
     ```json
     {
          "wallet": {
              "entity_type": "user",
              "entity_id": "66f24525c87abf12f67a9521",
              "balance": 1000.00
          }
      }
   - Response:
     ```json
     {
          "_id": "66f251d53f1707d69d5e0a4d",
          "balance": 1000.0,
          "created_at": "2024-09-24T05:44:53.484Z",
          "entity_id": "66f24525c87abf12f67a9521",
          "entity_type": "user",
          "updated_at": "2024-09-24T05:44:53.484Z"
      }

   - GET {base_url}/wallets
   - Header:
      - Authorization: jwt token
   - Response:
     ```json
     [
          {
              "_id": "66f251d53f1707d69d5e0a4d",
              "balance": 1000.0,
              "created_at": "2024-09-24T05:44:53.484Z",
              "entity_id": "66f24525c87abf12f67a9521",
              "entity_type": "user",
              "updated_at": "2024-09-24T05:44:53.484Z"
          }
      ]

3. **Transaction Management**
   - POST {base_url}/transactions: Create a new transaction for debit
   - Header:
      - Authorization: jwt token
      - Content-Type: application/json
   - Request body:
     ```json
     {
          "transaction": {
              "amount": 100.00,
              "transaction_type": "debit",
              "target_wallet_id": null,
              "source_wallet_id": "66f251d53f1707d69d5e0a4d"
          }
      }
   - Response:
     ```json
     {
          "_id": "66f24655420978cbe12dd85e",
          "amount": "100.0",
          "created_at": "2024-09-24T04:55:49.504Z",
          "source_wallet_id": "66f2456ec87abf12f67a9522",
          "target_wallet_id": null,
          "transaction_type": "debit",
          "updated_at": "2024-09-24T04:55:49.504Z"
      }

   - POST {base_url}/transactions: Create a new transaction for credit
   - Header:
      - Authorization: jwt token
      - Content-Type: application/json
   - Request body:
     ```json
     {
          "transaction": {
              "amount": 100.00,
              "transaction_type": "credit",
              "target_wallet_id": "66f251d53f1707d69d5e0a4d",
              "source_wallet_id": null
          }
      }
   - Response:
     ```json
     {
          "_id": "66f24667420978cbe12dd85f",
          "amount": "100.0",
          "created_at": "2024-09-24T04:56:07.934Z",
          "source_wallet_id": null,
          "target_wallet_id": "66f2456ec87abf12f67a9522",
          "transaction_type": "credit",
          "updated_at": "2024-09-24T04:56:07.934Z"
      }
