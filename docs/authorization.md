# Authorization

>    alert: This section documents preliminary functionality. 
>    The functionality described below is still under development.

## Creating users and signing in

Backlift exposes the following API to facilitate user creation and management:

*   **Creating users:** (POST /backlift/auth/register)

    You can create new users by sending a POST request to your app's /backlift/auth/register URL. The data you send should contain a 'username' attribute and a 'password' attribute, or 'password1' and 'password2' attributes. 
        
        POST /backlift/auth/register {"username": "...", "password": "..."}

    Currently backlift does not perform validation on usernames or passwords, except that they must exist, and in the case of password1 and password2, they must match.

    Passwords are salted and hashed before being stored using [bcrypt](http://bcrypt.sourceforge.net/).

*   **Logging in:** (POST /backlift/auth/login)

	To log in a user, POST to the login url with a pair of 'username' and 'password' attributes. They will be compared against the salted and hashed password store and if they match, the user will be logged in.

	When a user is logged in, two cookies will be set on the client, a session ID and a 'user' cookie that contains the user id.

*   **Logging out:** (POST or GET /backlift/auth/logout)

	To log out a user, POST or GET to the logout url.

	If you send a GET request, you can include a '_next' url parameter with a redirect url where the user will be sent after being logged out. For example the following link will log out a user and return them to the 'dashboard' page:

	    <a href="/backlift/auth/logout?_next=/dashboard"> Log out </a>

	By default the user will be redirected to '/' if logged out via a GET request.


## Permissions and access control

Backlift's authorization module allows you to control access to persisted objects. In backlift you authorize access to data, and build behaviors around that. A user profile object may be marked as readonly, which means that the server will reject attempts to update the profile object unless the currently logged-in user is the owner of that profile object.

Backlift uses the following attributes on objects in order to control access:

*   **_owner**: Whenever a user is logged-in, any objects created will have the _owner attribute set to the current user's id. This attribute is read-only and managed by the server.

*   **_groups**: A list of groups to which the object belongs.

*   **_public_permissions**, **_group_permissions**, **_owner_permissions**: Govern what actions are authorized on this object. It is a string containing any of the following characters. If one of the characters below is included in the string, it will grant the associated permission:
    
    * **'r'**: read   
    * **'w'**: write   
    * **'c'**: create  
    * **'d'**: delete

For example, the following object is only accessible to the owner:

	{ "_owner": "...", 
	  "_id": "...", 
	  "_owner_permissions": "rwcd",
	  "_group_permissions": "",
	  "_public_permissions": ""}

These are the default permissions that an object will be assigned, if the respective permissions attributes are missing on an object:

* owner: read, write, create, delete
* group: read, write
* public: read


## Using validation rules to set permissions

Authorization depends on validation to ensure that the model attributes responsible for controlling user access are correctly configured and not altered by malicious clients. Currently these rules are set using the .backlift file. Here are a few examples of how to correctly set permissions on your models using the 'collections' hash in the .backlift file:

*   Making the models of a collection readonly for the public:

        collections:
          tweets:
            message: {type: 'string', max: 140, required: yes}
            _public_permissions: {default: 'r', readonly: yes}

    In this example, tweets can be created and modified by users, due to default permissions. However the public can only read tweets, not change them. Tweets currently only contain the message, but could contain other attributes, such as the geo-location where the tweet was created.

*   Making a private user object:

        collections:
          users:
            _id: {type: 'auto:current_user', readonly: yes}
            _public_permissions: {default: '', readonly: yes}

    This object's id is always set to the current user's id. This ensures that only one model in the 'users' collection will exist for each user since each model '_id' must be unique in a collection. This object also cannot be read by the public. However the owner and member's of this object's group, if set, will have access based on the default permissions listed above.


