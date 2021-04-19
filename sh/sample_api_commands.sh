#!/bin/bash

export ADMIN_AUTH_KEY=$(curl -d "email=admin@user.test&password=passwd123" -X POST http://localhost:3000/admin_api/authenticate)
export CLIENT1_AUTH_KEY=$(curl -d "auth_key=jEGHzpHurQsX4m9VD8meJg" -X POST http://localhost:3000/client_api/authenticate)
export CLIENT2_AUTH_KEY=$(curl -d "auth_key=0LMLjxFM9E9LW5n0uK5hqQ" -X POST http://localhost:3000/client_api/authenticate)


# AdminApi
curl -H "Authorization: Bearer $ADMIN_AUTH_KEY" -d "title=Curl test title&desc=Created via curl&active=true" -X POST http://localhost:3000/admin_api/notifications

curl -H "Authorization: Bearer $ADMIN_AUTH_KEY" http://localhost:3000/admin_api/notifications
curl -H "Authorization: Bearer $ADMIN_AUTH_KEY" http://localhost:3000/admin_api/clients

curl -H "Authorization: Bearer $ADMIN_AUTH_KEY"  -d "client_id=my_client_uuid&notification_id=my_notification_uuid" -X POST http://localhost:3000/admin_api/notification_assignments

# ClientApi
curl -H "Authorization: Bearer $CLIENT1_AUTH_KEY" http://localhost:3000/client_api/notifications
curl -H "Authorization: Bearer $CLIENT1_AUTH_KEY" http://localhost:3000/client_api/investment_portfolio
