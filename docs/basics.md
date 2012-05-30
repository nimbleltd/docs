# Backlift basics

## App templates

Backlift comes with a set of examples and starter templates that you can access directly with the backlift create command. Just type:

    backlift create:<template name> newapp 

You can find a list of available templates on github at http://github.com/backlift/backlift-templates.

We'd love to add your example or starter template to the backlift command line utility. Just submit a pull request to the github project above. We'll evaluate it and, if we approve, we'll make it available directly by typing `backlift create:<your app here>`.

## Project layout

At a minimum your backlift app has three files, a main javascript file, a javascript template (JST) file and a CSS file:

* **app/scripts/main.js**: At a minimum this file contains a router that maps URLs to Views. It can also contain data Models and Collections, and Views that display the data. However it's generally best to separate out those classes and place them into other .js files.

* **app/templates/*.jst**: JST stands for JavaScript Template. Templates are combined with data from your model and "rendered" into HTML. Larger sites may have several templates, one for each chunk of data that will be displayed. Also JST files can be rendered heirarchically, allowing one JST to act as a layout for the rest of the website. JSTs will be available to your code via the `window.JST` object. For example, a template called 'home.jst' will be available to your app as `window.JST.home` or just `JST.home`. 

* **app/styles/styles.css**: controls how your website looks

There are a few additional project files:

* **the /libraries folder**: This is where third party libraries, such as bootstrap.css and backbone.js go.

* **the setup.js file**: For some backlift template, a setup javascript file is used to create the App namespace and define commonly used convenience classes.

* **the .backlift file**: This is the configuration file that determines how your project is packaged, and can be used to define server side validation rules.

After your files are uploaded using `backlift push` they will be publicly accessible at:

    <your app id>.backliftapp.com/public/<file path> 

This avoids conflicts between your public files, and paths that you might set up using your backbone router.

You may have noticed that index.html was not on the above list. If no index.html file exists in the project, backlift will create one automatically that includes links to the scripts, styles, templates that were generated based on your .backlift file.


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

The data you send can either be a JSON object or a url-encoded set of key-value pairs.

Backlift stores the data as JSON documents. That means you don't need to spend time defining the schema in advance. Backlift will happily persist any object with any set of attributes and make it available for retreival. Later when you want to deploy your app in a production environment, you can setup validation via the .backlift config file or the admin panel. (coming soon!)
