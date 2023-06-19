#!/bin/bash

# Example:
# curl -X POST "http://localhost:5003/todos/{username}" \
#   -H "Content-Type: application/json" \
#   -d '{"todo": "Your task here"}'

USERNAME="user"
REQUEST_TYPE="get"
NEW_TODO=""
TODO_IDX=""

function get_todo() {
    curl -s -X GET "http://localhost:5003/todos/${USERNAME}" \
        -H "Content-Type: application/json" \
        | jq .
}

function post_todo() {
    NEW_TODO=$1
    curl -X POST "http://localhost:5003/todos/${USERNAME}" \
        -H "Content-Type: application/json" \
        -d '{"todo": "'"$NEW_TODO"'"}'
}

function delete_todo() {
    TODO_IDX=$1
    curl -X DELETE "http://localhost:5003/todos/${USERNAME}" \
        -H "Content-Type: application/json" \
        -d '{"todo_idx": '"$TODO_IDX"'}'
}

function todo_length {
    get_todo | jq 'length'
}

# if [ "$1" == "-u" ] || [ "$1" == "--user" ]; then
#     USERNAME="$2"
#     echo "Username set to $USERNAME"
#     shift 2
# fi

# if [ "$1" == "get" ]; then
#     get_todo
# elif [ "$1" == "post" ]; then
#     post_todo "$2"
# elif [ "$1" == "delete" ]; then
#     delete_todo "$2"
# else
#     echo "Invalid command. Usage: todo.sh [-u|--user USERNAME] [get|post|delete]"
# fi


while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
    -u | --user)
        USERNAME="$2"
        shift # past argument
        shift # past value
        ;;
    get)
        REQUEST_TYPE="get"
        # get_todo
        shift # past argument
        ;;
    post)
        REQUEST_TYPE="post"
        NEW_TODO="$2"
        # post_todo "$NEW_TODO"
        shift # past argument
        shift # past value
        ;;
    delete)
        REQUEST_TYPE="delete"
        TODO_IDX="$2"
        # check if $2 is a number
        # if ! [[ "$TODO_IDX" =~ ^[0-9]+$ ]]; then
        #     echo "Invalid todo index. Usage: todo.sh delete [TODO_INDEX]"
        #     exit 1
        # fi
        # delete_todo "$TODO_IDX"
        shift # past argument
        shift # past value
        ;;
    *)
        echo "Invalid command. Usage: todo.sh [-u|--user USERNAME] [get|post|delete] [NEW_TODO|TODO_INDEX]"
        exit 1
        ;;
    esac
done

if [ "$REQUEST_TYPE" == "get" ]; then
    get_todo
elif [ "$REQUEST_TYPE" == "post" ]; then
    echo "NEW_TODO: \"$NEW_TODO\""
    post_todo "$NEW_TODO"
elif [ "$REQUEST_TYPE" == "delete" ]; then
    TODO_LENGTH=$(todo_length)
    # if TODO_IDX is negative, add TODO_LENGTH to it
    if [ "$TODO_IDX" -lt 0 ]; then
        TODO_IDX=$((TODO_IDX + TODO_LENGTH))
    fi
    # TODO_IDX=$((TODO_IDX % TODO_LENGTH))
    echo "TODO_IDX: $TODO_IDX"
    delete_todo "$TODO_IDX"
else
    echo "Invalid command. Usage: todo.sh [-u|--user USERNAME] [get|post|delete]"
fi