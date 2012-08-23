# Backlift basics

## App templates

Backlift comes with a set of examples and starter templates that you can access directly with the backlift create command. Just type:

    backlift create:<template name> newapp 

You can find a list of available templates on github at http://github.com/backlift/backlift-templates.

We'd love to add your example or starter template to the backlift command line utility. Just submit a pull request to the github project above. We'll evaluate it and, if we approve, we'll make it available directly by typing `backlift create:<your app here>`.

## Project layout

At the root of your project folder is a public folder. This contains all the publicly accessible files that make up your webapp. At a minimum your backlift app has three files, a main javascript file, a javascript template (JST) file and a CSS file:

* **/public/app/scripts/main.js**: At a minimum this file contains a router that maps URLs to Views. It can also contain data Models and Collections, and Views that display the data. However it's generally best to separate out those classes and place them into other .js files.

* **/public/app/templates/*.jst**: JST stands for JavaScript Template. Templates are combined with data from your model and "rendered" into HTML. Larger sites may have several templates, one for each chunk of data that will be displayed. Also JST files can be rendered heirarchically, allowing one JST to act as a layout for the rest of the website. JSTs will be available to your code via the `window.JST` object. For example, a template called 'home.jst' will be available to your app as `window.JST.home` or just `JST.home`. 

* **/public/app/styles/styles.css**: controls how your website looks

There are a few additional project files:

* **the /public/libraries folder**: This is where third party libraries, such as bootstrap.css and backbone.js go.

* **the /public/setup.js file**: For some backlift template, a setup javascript file is used to create the App namespace.

* **the config.yml file**: This is the configuration file that determines how your project is packaged, and can be used to define server side validation rules.

After your files are uploaded using `backlift push` they will be publicly accessible at:

    https://<your app id>.backliftapp.com/public/<file path> 

This avoids conflicts between your public files, and paths that you might set up using your backbone router.

You may have noticed that index.html was not on the above list. If no index.html file exists in the project, backlift will create one automatically that includes links to the scripts, styles, templates that were generated based on your config.yml file.


## The admin site

Each app gets a unique admin page that can be used for debugging and, in the future, managing security features like validation and authorization. You can view your app's admin page by running:

    backlift admin

from your app's working folder, or visit

    https://www.backlift.com/admin#<app id>

As you develop your app, this page will change to reflect your app's collections and request history. This makes it a valuable debugging tool.


## Data persistence

When communicating with the Backlift server, as long as you prefix your AJAX urls with "/backliftapp/", the backlift server will automatically store and fetch any json data that you send. For example, in backbone, you can set the url attribute of your collections, or the urlRoot attribute of your models using the "/backliftapp/" prefix and then use backbone's standard save or create methods.

Specifically:

* GET /backliftapp/&lt;collection&gt;: will retrieve a list of the items in the collection.

* POST /backliftapp/&lt;collection&gt;: will create a new item and add it to the collection.

* PUT /backliftapp/&lt;collection&gt;/&lt;item_id&gt;: will update an item in the collection.

* DELETE /backliftapp/&lt;collection&gt;/&lt;item_id&gt;: will delete an item.

The data should be sent in the request body, and can either be a JSON object or a url-encoded set of key-value pairs. 

Backlift stores the data as JSON documents. That means you don't need to spend time defining the schema in advance. Backlift will happily persist any object with any set of attributes and make it available for retreival. Later when you want to deploy your app in a production environment, you can setup validation via the config.yml config file or the admin panel. (coming soon!)


## Special object attributes

Each time the backlift server persists a new object, a few attributes are applied automatically:

* **'id'**: If no id is set, the server will assign a unique uuid to each model and store it in the 'id' attribute. If there is an id, backlift will ensure that it is unique. 

* **'_owner'**: This attribute is automatically assigned to the currently logged-in user's id attribute, if there is a currently logged-in user. This value is read-only.

* **'_created'**: When a new object is created, this attribute is set with the current date and time in ISO standard format. This value is read-only.

* **'_modified'**: Each time an object is updated, this attribute is set with the current date and time in ISO standard format. This value is read-only.

* **'_id'**: Backlift mirrors the id attribute in an '_id' attribute. The '_id' attribute is the primary attribute used to store and retrieve data by the backlift database. In the future this attribute may be filtered out, so don't use it.