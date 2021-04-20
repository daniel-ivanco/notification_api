# B2B performance – notification API
### Basic Description
This is a Ruby on Rails backend implementing B2B performance notification API. It allows sending notifications to B2B partners regarding their investment portfolio and portfolio performance through a REST API. The application uses `www.alphavantage.co` API to fetch real stock prices.

### Running and testing the application
There are 2 options to run the application:
  - In a local machine environment (development mode)
  - Using Docker (production mode)

#### Local machine env
To run the application on your local machine environment you need to have preinstalled these components:
  - PostgreSQL 12 DB (or higher)
  - Ruby 2.7.2
  - RubyGems packaging system

Next, you need to clone this repo and run these commands inside the folder where the repo is cloned:
  1. `bundle install`
  2. `rails db:migrate`
  3. `rails db:seed`

You can run tests using this command `rails test`.

Finally you can run the server:
  - `rails s`

The server is running now in development mode and listens on port 3000. It can be accessed here `http://localhost:3000`

#### Docker
To run the application using Docker you need to have Docker preinstalled on your machine.
Next, you need to clone this repo and run these commands inside the folder where the repo is cloned:
  1. `docker-compose build`
  2. `docker-compose run --rm notification-api sh -c "bundle install"`
  3. `docker-compose run --rm notification-api sh -c "rails db:create RAILS_ENV=production; rails db:migrate RAILS_ENV=production; rails db:seed RAILS_ENV=production"`
  4. `docker-compose run --rm notification-api sh -c "rails db:create RAILS_ENV=test; rails db:migrate RAILS_ENV=test"`

You can run tests using this command `docker-compose run --rm notification-api rails test`.

Finally you can run the server:
  - `docker-compose up`

The server is running now in production mode and listens on port 3000. It can be accessed here `http://localhost:3000`

### Using the application
The backend consists of 2 APIs:
  - Admin API
  - Client API

#### Admin API
Are used by the company's admin employees. Prior to using the API, authentication is required to obtain JWT auth token which is required to be passed as a bearer token in the Authorization request header when using the API. For purpose of this exercise there is created 1 Admin user with these credentials:
 - email: `admin@user.test`
 - password: `passwd123`

 To obtain the auth token (which will be valid for 15 minutes) you need to run:
`export ADMIN_AUTH_KEY=$(curl -d "email=admin@user.test&password=passwd123" -X POST http://localhost:3000/admin_api/authenticate)`

##### The API has following functions:
  * Get all existing notifications with all clients they are currently assigned to (with seen flag determining if the client has already seen it or not). Run this command:
    * `curl -H "Authorization: Bearer $ADMIN_AUTH_KEY" http://localhost:3000/admin_api/notifications`
  * Get all existing clients. Run this command:
    * `curl -H "Authorization: Bearer $ADMIN_AUTH_KEY" http://localhost:3000/admin_api/clients`
  * Create a new notification. Run this command (replace test_title and test_desc with actual values):
    * `curl -H "Authorization: Bearer $ADMIN_AUTH_KEY" -d "title=test_title&desc=test_desc&active=true" -X POST http://localhost:3000/admin_api/notifications`
  * Assign notification to a specific client. For this you need to obtain `client_uuid` and `notification_uuid` from previous steps. Then run this command (replace client_uuid and notification_uuid with real values):
    * `curl -H "Authorization: Bearer $ADMIN_AUTH_KEY"  -d "client_id=client_uuid&notification_id=notification_uuid" -X POST http://localhost:3000/admin_api/notification_assignments`
    * you can check if the newly added client is assigned to the notification with the command from the first bullet point of this list


#### Client API
Are used by the company's B2B partners. Prior to using the API, authentication is required to obtain JWT auth token which is required to be passed as a bearer token in the Authorization request header when using the API. For purpose of this exercise there are created 2 clients these secret keys:
 - client_1: `jEGHzpHurQsX4m9VD8meJg`
 - client_2: `0LMLjxFM9E9LW5n0uK5hqQ`

 To obtain the auth tokens (which will be valid for 15 minutes) for these 2 clients you need to run:
 * `export CLIENT1_AUTH_KEY=$(curl -d "auth_key=jEGHzpHurQsX4m9VD8meJg" -X POST http://localhost:3000/client_api/authenticate)`
 * `export CLIENT2_AUTH_KEY=$(curl -d "auth_key=0LMLjxFM9E9LW5n0uK5hqQ" -X POST http://localhost:3000/client_api/authenticate)`

##### The API has following functions:
  * Get all assigned notifications for a specific client. Run this command:
    * `curl -H "Authorization: Bearer $CLIENT1_AUTH_KEY" http://localhost:3000/client_api/notifications`
  * Get client's own investment portfolio. Run this command:
    * `curl -H "Authorization: Bearer $CLIENT1_AUTH_KEY" http://localhost:3000/client_api/investment_portfolio`
    * __IMPORTANT__: Please bear in mind that the application uses a free Alphavantage account to retrieve prices for companies inside the portfolio. This free account is limited to fetch 5 requests per minute, which means it takes about 8 minutes to fetch fresh data for a portfolio (40 companies). But this delay applies only to the first call of a current day. All the following calls that day are instant as the company's price information is stored locally for future calculations.
