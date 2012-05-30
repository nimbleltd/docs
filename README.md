# Backlift

## Introduction 

Backlift wants to make building and deploying websites easier, faster and more creative. 

Backlift's server, templates and helper libraries support:

* **Asynchronous updates:** Build apps that respond immediately to user actions while data is sent the the server in the background. 
* **API discovery:** Backlift will let you persist data without specifying the API up front. If you follow standard RESTful conventions, backlift will accept whatever data you throw at it.
* **Familiar libraries:** Backlift currently works with [Backbone.js](http://backbonejs.org). We plan to integrate other javascript MVC libraries in the future.

Backlift's goals are to facilitate:

* rapid user experience prototyping,
* learning to write front-end javascript code, and eventually,
* deploying production websites used by millions.

Please visit [backlift.com](https://www.backlift.com) to access your backlift account.

Bugs or feature requests for backlift can be submitted to the [issues](http://github.com/backlift/docs/issues) page of this documentation's github project.

The source to this documentation is available [on github](http://github.com/backlift/docs). We will happily accept pull requests to the docs.


## Philosophy (lite)

* Backlift doesn't want to change the way you work, it wants to reduce your workload. 
* Backlift isn't a new library or API, it works with existing libraries, such as Backbone.js.
* Backlift doesn't want to lock you in. The code you deploy to backlift can be used with a different stack. If at some point you outgrow backlift, you can migrate to a different back-end without rewriting your front-end code.


#  Getting Started

## Setup the Backlift Command Line Utility

Open up your terminal and download the Backlift Command Line Interface (CLI) by typing:

    sudo easy_install backlift

Alternatively, you can use pip to install the Backlift CLI into a virtual environment.

Once you have backlift installed, create an account at [backlift.com](https://backlift.com) by clicking on the 'Sign-in' button in the upper right corner. You will need a registration key. In order to obtain one please click the 'Get Early Access' link and supply your email address. We will send you a key as soon as possible.

Once you have your api-key, setup backlift with the command:

    backlift setup <api-key>

Now you're ready to create new apps and upload them to backlift.

From time to time you should make sure that you have the most recent version of the Backlift CLI. You can check that by typing `backlift --version`. It should match the 'Backlift CLI current version' listed on your account dashboard. You can update your Backlift CLI by entering the command 

    sudo easy_install --update backlift.


## Create and Upload a new app

Create a new app with the command:

    backlift create newapp

This will create a new folder in the current directory called 'newapp' and begin downloading the backlift default project template. Once the project template has finished downloading, check it out by opening the 'newapp' folder with a text editor.

To see this app running on a public web server, first change directories into the 'newapp' folder and type 'backlift push'.

    cd newapp
    backlift push

This will upload the content of the 'newapp' folder to Backlift. Alternatively you can use the command:
    `backlift watch`

The watch command will first upload the 'newapp' folder and then wait for changes to the project. Any time you edit and save a file in the 'newapp' folder while the watch command is running, your changes will automatically by synced to Backlift.


## View and manage your app

You can launch a browser to view your app by typing:

    backlift open

You can alternatively view the website's admin page by typing:

    backlift admin

That's all there is to it! The basic Backlift template contains a tutorial that will show you how to build a backbone.js app with Backlift. 

