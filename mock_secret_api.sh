#!/bin/bash

# Simulated Secret Manager API response

cat <<EOF
{
    "DB_HOST": "localhost",
    "DB_PORT": "5432",
    "DB_USER": "test_user",
    "DB_PASSWORD": "test_password",
    "API_KEY" : "abc123"
}
EOF
