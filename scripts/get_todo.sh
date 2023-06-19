#!/bin/bash
# Example:
# curl -X POST "http://localhost:5003/todos/{username}" \
#   -H "Content-Type: application/json" \
#   -d '{"todo": "Your task here"}'

USERNAME="user"

curl -s -X GET "http://localhost:5003/todos/${USERNAME}" \
    -H "Content-Type: application/json" \
    | jq .
