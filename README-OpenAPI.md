# TODO Plugin API

This API allows you to create and manage a TODO list using ChatGPT. If you do not know the user's username, ask them first before making queries to the plugin. Otherwise, use the username "global".

## Base URL

```
http://localhost:5003
```

## Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| [GET](#get)    | `/todos/{username}` | Get the list of todos for a specific user. |
| [POST](#post)   | `/todos/{username}` | Add a todo to the list for a specific user. |
| [DELETE](#delete) | `/todos/{username}` | Delete a todo from the list for a specific user. |

## Paths
- `/todos/{username}`

<a name="get"></a>
### GET

---

#### Request

```
GET /todos/{username}
```

##### Path Parameters

- `username` (string, required): The name of the user.

##### Example

```
GET /todos/johndoe
```

#### Response

##### Success

```
200 OK
```

```json
{
  "todos": [
    "Buy groceries",
    "Finish homework"
  ]
}
```

##### Error

```
404 Not Found
```

```json
{
  "error": "User not found"
}
```

<a name="post"></a>
### POST

---

Add a todo to the list for a specific user.

#### Request

```
POST /todos/{username}
```

##### Path Parameters

- `username` (string, required): The name of the user.

##### Request Body

```json
{
  "todo": "Do laundry"
}
```

##### Example

```
POST /todos/johndoe
```

```json
{
  "todo": "Do laundry"
}
```

#### Response

##### Success

```
200 OK
```

##### Error

```
400 Bad Request
```

```json
{
  "error": "Invalid request body"
}
```

<a name="delete"></a>
### DELETE

---

Delete a todo from the list for a specific user.

#### Request

```
DELETE /todos/{username}
```

##### Path Parameters

- `username` (string, required): The name of the user.

##### Request Body

```json
{
  "todo_idx": 1
}
```

##### Example

```
DELETE /todos/johndoe
```

```json
{
  "todo_idx": 1
}
```

#### Response

##### Success

```
200 OK
```

##### Error

```
400 Bad Request
```

```json
{
  "error": "Invalid request body"
}
```

