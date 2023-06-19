# ChatGPT plugins quickstart

Get a todo list ChatGPT plugin up and running in under 5 minutes using Python. This plugin is designed to work in conjunction with the [ChatGPT plugins documentation](https://platform.openai.com/docs/plugins). If you do not already have plugin developer access, please [join the waitlist](https://openai.com/waitlist/plugins).

## Setup locally

To install the required packages for this plugin, run the following command:

```bash
pip install -r requirements.txt
```

To run the plugin, enter the following command:

```bash
python main.py
```

Once the local server is running:

1. Navigate to https://chat.openai.com. 
2. In the Model drop down, select "Plugins" (note, if you don't see it there, you don't have access yet).
3. Select "Plugin store"
4. Select "Develop your own plugin"
5. Enter in `localhost:5003` since this is the URL the server is running on locally, then select "Find manifest file".

The plugin should now be installed and enabled! You can start with a question like "What is on my todo list" and then try adding something to it as well! 

## Setup remotely

### Cloudflare workers

### Code Sandbox

### Replit

## Getting help

If you run into issues or have questions building a plugin, please join our [Developer community forum](https://community.openai.com/c/chat-plugins/20).

## API Usage

### GET /todos/{username}

Get all todos for a given username.

#### Parameters

| Name | In | Type | Required | Description |
| ---- | -- | ---- | -------- | ----------- |
| username | path | string | true | The username to get todos for. |

#### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Success | [Todo](#todo) |

### POST /todos/{username}

Add a todo for a given username.

#### Parameters

| Name | In | Type | Required | Description |
| ---- | -- | ---- | -------- | ----------- |
| username | path | string | true | The username to add a todo for. |

#### Responses

| Code | Description | Schema |
## Plugin devtools

**TODO List (no auth)**
Manage your TODO list. You can add, remove and view your TODOs.
Plugin id: complete-manifest-f020e65c-8b26-4a9e-a158-27ca71b25120

### Validated manifest

[ai-plugin.json]:

```json
{
  "schema_version": "v1",
  "name_for_human": "TODO List (no auth)",
  "name_for_model": "todo",
  "description_for_human": "Manage your TODO list. You can add, remove and view your TODOs.",
  "description_for_model": "Plugin for managing a TODO list, you can add, remove and view your TODOs.",
  "auth": {
    "type": "none"
  },
  "api": {
    "type": "openapi",
    "url": "http://localhost:5003/openapi.yaml"
  },
  "logo_url": "http://localhost:5003/logo.png",
  "contact_email": "legal@example.com",
  "legal_info_url": "http://example.com/legal"
}
```

### Validated OpenAPI spec

[openapi.yaml]:

```yaml
openapi: 3.0.1
info:
  title: TODO Plugin
  description: A plugin that allows the user to create and manage a TODO list using ChatGPT. If you do not know the user's username, ask them first before making queries to the plugin. Otherwise, use the username "global".
  version: "v1"
servers:
  - url: http://localhost:5003
paths:
  /todos/{username}:
    get:
      operationId: getTodos
      summary: Get the list of todos
      parameters:
        - in: path
          name: username
          schema:
            type: string
          required: true
          description: The name of the user.
      responses:
        "200":
          description: OK
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/getTodosResponse"
    post:
      operationId: addTodo
      summary: Add a todo to the list
      parameters:
        - in: path
          name: username
          schema:
            type: string
          required: true
          description: The name of the user.
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: "#/components/schemas/addTodoRequest"
      responses:
        "200":
          description: OK
    delete:
      operationId: deleteTodo
      summary: Delete a todo from the list
      parameters:
        - in: path
          name: username
          schema:
            type: string
          required: true
          description: The name of the user.
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: "#/components/schemas/deleteTodoRequest"
      responses:
        "200":
          description: OK

components:
  schemas:
    getTodosResponse:
      type: object
      properties:
        todos:
          type: array
          items:
            type: string
          description: The list of todos.
    addTodoRequest:
      type: object
      required:
        - todo
      properties:
        todo:
          type: string
          description: The todo to add to the list.
          required: true
    deleteTodoRequest:
      type: object
      required:
        - todo_idx
      properties:
        todo_idx:
          type: integer
          description: The index of the todo to delete.
          required: true
```

# Prompt for ChatGPT

```
// Plugin for managing a TODO list, you can add, remove and view your TODOs.
namespace todo {

// Get the list of todos
type getTodos = (_: {
// The name of the user.
username: string,
}) => any;

// Add a todo to the list
type addTodo = (_: {
// The name of the user.
username: string,
// The todo to add to the list.
todo: string,
}) => any;

// Delete a todo from the list
type deleteTodo = (_: {
// The name of the user.
username: string,
// The index of the todo to delete.
todo_idx: number,
}) => any;

} // namespace todo
```

---
[[Back to top]](#top)

[ai-plugin.json]: ./.well-known/ai-plugin.json
[openapi.yaml]: ./openapi.yaml