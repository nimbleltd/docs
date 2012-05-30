# Backlift

## Introduction 

Backlift wants to make building websites easier, faster and more creative. We hope it will be useful for:

* rapid user experience prototyping,
* learning to write front-end javascript code, and eventually,
* building production websites used by millions.

Please visit [backlift.com](https://www.backlift.com) to access your backlift account.

Bugs or feature requests for backlift can be submitted to the [issues](http://github.com/backlift/docs/issues) page of this documentation's github project.

The source to this documentation is available [on github](http://github.com/backlift/docs). We will happily accept pull requests to the docs.

Thanks!

## Philosophy (lite)

* Backlift doesn't want to change the way you work, it wants to eliminate work. 
* Backlift isn't a new library or API, it works with existing libraries, such as Backbone.js.
* Backlift doesn't want to lock you in. The code you deploy to backlift can be used with a different stack. If at some point you outgrow backlift, you can migrate to a different back-end without rewriting your front-end code.


#  Getting Started

## Setup the Backlift Command Line Utility

Open up your terminal and download the Backlift Command Line Interface (CLI) by typing:

    sudo easy_install backlift

Alternatively, you can use pip to install the Backlift CLI into a virtual environment. If you don't know what that means, don't worry about it right now.

Once you have backlift installed, setup backlift using your account's API key:

    backlift setup <api-key>

(You will find your api-key in your account dashboard.) 

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

## Further documentation

The full documentation can be found at http://backlift.github.com/docs. 