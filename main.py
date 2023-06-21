import json
import quart
import quart_cors
from quart import request

# Create a Quart application with CORS enabled
app = quart_cors.cors(quart.Quart(__name__), allow_origin="https://chat.openai.com")

# A dictionary to store TODO lists for each user
# Note: This data does not persist if the Python session is restarted
_TODOS = {}

@app.post("/todos/<string:username>")
async def add_todo(username):
    """
    Handle POST requests to add a TODO item.
    
    Args:
        username (str): The username obtained from the URL.
        
    Returns:
        quart.Response: A response with status code 200.
    """
    # Get the request data
    request_data = await quart.request.get_json(force=True)
    
    # If the user does not have a TODO list yet, create an empty one
    if username not in _TODOS:
        _TODOS[username] = []
    
    # Add the TODO item to the user's list
    _TODOS[username].append(request_data["todo"])
    
    return quart.Response(response='OK', status=200)

@app.get("/todos/<string:username>")
async def get_todos(username):
    """
    Handle GET requests to retrieve a user's TODO list.
    
    Args:
        username (str): The username obtained from the URL.
        
    Returns:
        quart.Response: A response containing the TODO list in JSON format.
    """
    # Get the user's TODO list, or an empty list if the user has no list
    todos = _TODOS.get(username, [])
    
    return quart.Response(response=json.dumps(todos), status=200)

@app.delete("/todos/<string:username>")
async def delete_todo(username):
    """
    Handle DELETE requests to remove a TODO item.
    
    Args:
        username (str): The username obtained from the URL.
        
    Returns:
        quart.Response: A response with status code 200.
    """
    # Get the request data
    request_data = await quart.request.get_json(force=True)
    
    # Get the index of the TODO item to delete
    todo_idx = request_data["todo_idx"]
    
    # If the index is valid, delete the TODO item
    if 0 <= todo_idx < len(_TODOS[username]):
        _TODOS[username].pop(todo_idx)
    
    return quart.Response(response='OK', status=200)

@app.get("/logo.png")
async def plugin_logo():
    """
    Handle GET requests for the plugin's logo.
    
    Returns:
        quart.Response: A response containing the logo file.
    """
    filename = 'logo.png'
    return await quart.send_file(filename, mimetype='image/png')

@app.get("/.well-known/ai-plugin.json")
async def plugin_manifest():
    """
    Handle GET requests for the plugin's manifest file.
    
    Returns:
        quart.Response: A response containing the manifest file.
    """
    with open("./.well-known/ai-plugin.json") as f:
        text = f.read()
        return quart.Response(text, mimetype="text/json")

@app.get("/openapi.yaml")
async def openapi_spec():
    """
    Handle GET requests for the OpenAPI specification of the API.
    
    Returns:
        quart.Response: A response containing the OpenAPI specification.
    """
    with open("openapi.yaml") as f:
        text = f.read()
        return quart.Response(text, mimetype="text/yaml")

def main():
    """
    Start the Quart server.
    """
    app.run(debug=True, host="0.0.0.0", port=5003)

if __name__ == "__main__":
    main()