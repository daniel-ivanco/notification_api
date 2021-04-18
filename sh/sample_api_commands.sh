#!/bin/bash

ADMIN_AUTH_KEY=$(curl -d "email=admin@user.test&password=passwd123" -X POST http://localhost:3000/admin_api/authenticate)
CLIENT_AUTH_KEY=$(curl -d "auth_key=ga/H3Y6VBvOj7Sov51ABW0TBCcRo7NfWQyjvzI6QbKo=" -X POST http://localhost:3000/client_api/authenticate)


