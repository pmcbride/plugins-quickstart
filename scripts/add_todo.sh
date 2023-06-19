#!/bin/bash
# Example:
# curl -X POST "http://localhost:5003/todos/{username}" \
#   -H "Content-Type: application/json" \
#   -d '{"todo": "Your task here"}'

USERNAME="user"
NEW_TODO=$1

curl -X POST "http://localhost:5003/todos/${USERNAME}" \
    -H "Content-Type: application/json" \
    -d '{"todo": "'"$NEW_TODO"'"}'

curl -s -X GET "http://localhost:5003/todos/${USERNAME}" \
    -H "Content-Type: application/json" \
    | jq .