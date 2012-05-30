# Authorization

>    alert: This section documents preliminary functionality. 
>    The functionality described below is still under development.

## Creating users and signing in

Backlift exposes a restful API to facilitate user creation and management:

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

*   **_public_permissions**, **_group_permissions**, **_owner_permissions**: Governs what actions are authorized on this object. It is a string containing any of the following characters. If one of the characters below is included in the string, it will grant the associated permission:
    
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

These are the default permissions that an object will be assigned, if any of the below attributes are missing on an object:

* owner: read, write, create, delete
* group: read, write
* public: read