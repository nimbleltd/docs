# Backlift API

This is a reference for the Backlift API. Each API entry will have a definition, for example:

    GET /backlift/auth/currentuser

This specifies that a GET request can be sent to the /backlift/auth/currentuser URL. 

All requests should use the app's domain as the host name. For example, the app <code>myapp-1ja0s</code> should send the above request to:

<pre><code class="no-highlight">https://myapp-1ja0s.backliftapp.com/backlift/auth/currentuser</code></pre>

In practice, requests using jQuery $.ajax functions can leave off the domain name, and just send requests to /backlift/auth/currentuser like so:

<pre><code class="javascript">$.ajax({
    type: "GET",
    url: "/backlift/auth/currentuser",
    success: function(result) { 
        console.log(result); 
    }
});  
</code></pre>  

All requests must be sent via https. Some requests require a logged in user or are effected by the current user session. The user session is managed using the auth login and logout APIs.

For PUT or POST requests, parameters must be sent in the body of the request and can either be a JSON object, or a list of URL encoded parameters. All responses will be JSON.

## Data Persistence

List of data persistence API entries:

* [Retrieve all models in a collection](api.html#retrieve-all-models-in-a-collection)
* [Create a new model](api.html#create-a-new-model)
* [Retrieve a model from a collection](api.html#retrieve-a-model-from-a-collection)
* [Update a model](api.html#update-a-model)
* [Delete a model](api.html#delete-a-model)

<p></p>

### Retrieve all models in a collection

    GET /backlift/data/<collection>

Returns a list of models in a collection. See the section on [persistence](persistence.html) for more detail.

Example usage:

    $.ajax({
        type: "GET",
        url: "/backlift/data/todos",
        success: function(result) { 
            console.log(result); 
        }
    });

    // result: 
    // [{
    //    "id":"8c064fd0-616f-4e18-91e5-959b5475516f",
    //    "title":"Do something",
    //    "order":1
    //    ...
    // },{
    //    "id":"4928bcd1-56f7-40e4-ba78-212bae096b5c",
    //    "title":"Something else",
    //    "order":2
    //    ...
    // }]


### Create a new model

    POST /backlift/data/<collection>

Creates a new model for a collection. See the section on [persistence](persistence.html) for more detail.

Parameters:

* **id**: the id of the new object. If no id is supplied, the object will be assigned a random id. 
* ... any additional parameters passed will become properties of the new model

Returns: A copy of the new model that will include a new id property if one has been assigned.

Example:

    $.ajax({
        type: "POST",
        url: "/backlift/data/todos", 
        data: {
            title: "Write Code",
            order: 3
        },
        success: function(result) { 
            console.log(result);
        } 
    });

    // result: 
    // {
    //    "id":"4928bcd1-56f7-40e4-ba78-212bae096b5c",
    //    "title":"Write Code",
    //    "order":"3",
    //    ...
    // }

Errors:

* **400 Bad Request**: If the data submitted doesn't pass one of the validation tests, the response will be a 400 error. The result will be a JSON object with a 'form_errors' property that contains a dictionary where the keys are names of the property for which a validation error was raised, and the values are lists of the validation errors for each property. For example:

      {"form_errors":
          "title": ["must be 25 characters or less"]
      } 

* **403 Not Authorized**: This error occurs if the currently signed-in user doesn't have permission to perform this operation. This can occur if the model has an id that matches an existing model in the collection owned by another user. It can also occur if the collection's schema has an _owner_permissions attribute with a default that lacks create permissions. See [permissions and access control](authorization.html#permissions-and-access-control) or more information.

### Retrieve a model from a collection

    GET /backlift/data/<collection>/<model_id>

Returns a models. See the section on [persistence](persistence.html) for more detail.

Example usage:

    $.ajax({
        type: "GET",
        url: "/backlift/data/todos/8c064fd0-616f-4e18-91e5-959b5475516f",
        success: function(result) { 
            console.log(result); 
        }
    });

    // result: 
    // {
    //    "id":"8c064fd0-616f-4e18-91e5-959b5475516f",
    //    "title":"Do something",
    //    "order":1
    //    ...
    // }


### Update a model

    PUT /backlift/data/<collection>/<model_id>

Updates a model. See the section on [persistence](persistence.html) for more detail.

Parameters:

* **id**: the id of the new object. If no id is supplied, the object will be assigned a random id. 
* ... any additional parameters passed will become properties of the new model

Returns: The updated model.

Example:

    $.ajax({
        type: "PUT",
        url: "/backlift/data/todos/4928bcd1-56f7-40e4-ba78-212bae096b5c", 
        data: {
            title: "Write MORE Code",
            order: 1
        },
        success: function(result) { 
            console.log(result);
        } 
    });

    // result: 
    // {
    //    "id":"4928bcd1-56f7-40e4-ba78-212bae096b5c",
    //    "title":"Write MORE Code",
    //    "order":"1",
    //    ...
    // }

Errors:

* **400 Bad Request**: If the data submitted doesn't pass one of the validation tests, the response will be a 400 error. The result will be a JSON object with a 'form_errors' property that contains a dictionary where the keys are names of the property for which a validation error was raised, and the values are lists of the validation errors for each property. For example:

      {"form_errors":
          "title": ["must be 25 characters or less"]
      } 

* **403 Not Authorized**: This error occurs if the currently signed-in user doesn't have permission to perform this operation. This can occur if the model to be updated is owned by another user, and the _public_permissions property excludes write permission. See [permissions and access control](authorization.html#permissions-and-access-control) or more information.


### Delete a model

    DELETE /backlift/data/<collection>/<model_id>

Removes a model from it's collection. See the section on [persistence](persistence.html) for more detail.

Example:

    $.ajax({
        type: "DELETE",
        url: "/backlift/data/todos/4928bcd1-56f7-40e4-ba78-212bae096b5c", 
        success: function(result) { 
            console.log("Deleted!");
        } 
    });

Errors:

* **403 Not Authorized**: This error occurs if the currently signed-in user doesn't have permission to perform this operation. This can occur if the model to be updated is owned by another user, and the _public_permissions property excludes delete permission. See [permissions and access control](authorization.html#permissions-and-access-control) or more information.

## Authorization and Users

### Register

    POST /backlift/auth/register  
    POST /backlift/auth/registernoemail
    POST /backlift/auth/registeremailonly

Creates a user. See the section on [authorization](authorization.html) for more detail.

Parameters: (see [validation reference](validation.html#validation-rule-reference))

    // regsiter and registernoemail
    username: {type: 'identifier', required: yes, unique: yes}     
    // register and registeremailonly
    email: {type: 'email', required: yes, unique: yes}             
    password: {type: 'password', required_if_empty: 'password1'}
    password1: {type: 'password', required_if_empty: 'password'}
    password2: {type: 'password', must_equal: 'password1'}

Returns: The created user model

Example using AJAX:

    $.ajax({
        type: "POST",
        url: "/backlift/auth/register", 
        data: {
            username: "username",
            email: "user@example.com",
            password1: "password",
            password2: "password"
        },
        success: function(result) { 
            console.log(result);
        } 
    });

    // result: 
    // {
    //    "id":"JPwLMxPHmJDkGpwk"
    //    "email": "user@example.com",
    //    "username": "username",
    //    "groups": ["JPwLMxPHmJDkGpwk"],
    //    "_modified": "2012-12-17T07:18:23.823617Z",
    //    "_created": "2012-12-17T07:18:23.823603Z",
    //    "profile": { 
    //        "username": "username",
    //        "_created": "2012-12-17T07:18:24.574915Z",
    //        "_modified":"2012-12-17T07:18:24.574940Z",
    //        "_owner": "JPwLMxPHmJDkGpwk"
    //    }
    // }

Example using a form:

    <form method="POST" action="/backlift/auth/registernoemail">
        Username: <input type="text" name="username">
        Password: <input type="password" name="password">
        <input type="hidden" name="_next" value="/home">
        <input type="submit">
    </form>



### Login

    POST /backlift/auth/login

Signs in a user. See the section on [authorization](authorization.html) for more detail.

Parameters: (see [validation reference](validation.html#validation-rule-reference))

<pre><code class="javascript">username: {type: 'identifier', required_if_empty: 'email'}
email: {type: 'email', required_if_empty: 'username'}
password: {type: 'password', required: yes}
</code></pre>

Example using AJAX:

    $.ajax({
        type: "POST",
        url: "/backlift/auth/login", 
        data: {
            username: "username",
            password: "password"
        },
        success: function(result) { 
            console.log(result);
        } 
    });

    // result: (same as register)
    // {
    //    "id":"JPwLMxPHmJDkGpwk"
    //    "email": "user@example.com",
    //    "profile": { 
    //        "username": "username",
    //        "_owner": "JPwLMxPHmJDkGpwk",
    //        ...
    //    },
    //    ...
    // }

Example using a form:

    <form method="POST" action="/backlift/auth/login">
        Username: <input type="text" name="username">
        Password: <input type="password" name="password">
        <input type="hidden" name="_next" value="/home">
        <input type="submit">
    </form>
