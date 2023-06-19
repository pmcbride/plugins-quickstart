#!/bin/bash
# Example:
# curl -X DELETE "http://localhost:5003/todos/{username}" \
#   -H "Content-Type: application/json" \
#   -d '{"todo_idx": 3}'

USERNAME="user"
TODO_IDX=$1

# curl -X DELETE "http://localhost:5003/todos/${USERNAME}" \
#     -H "Content-Type: application/json" \
#     -d '{"todo_idx": '"$TODO_IDX"'}'

# Run get_todo.sh
./get_todo.sh

# curl -s -X GET "http://localhost:5003/todos/${USERNAME}" \
#     -H "Content-Type: application/json" \
#     | jq .

