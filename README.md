# Kinnect

### This started from a boilerplate and Reference app providing tools and best practices to kickstart ionic app development
For background and more info, peep the fork 
<a href="https://github.com/leob/ionic-quickstarter" target="_blank">Original Fork</a>.

## Installation and usage

First, install ```nodejs```, ```cordova``` and the Ionic command line tools, as described on the <a
href="http://ionicframework.com/getting-started/" target="_blank">Ionic Getting Started</a> page.

It is also recommended to have the following command line tools installed:

```gulp``` and ```bower```

Check if these are installed, and if not install them 'globally' using ```npm``` with the "-g" (global) flag.

***Note:*** as described on Ionic's "Getting Started" page, the currently recommended version of ```nodejs``` is
version 4. Lower versions (0.x versions such as 0.10.x, 0.11.x or 0.12.x) are not recommended because they are quickly
becoming outdated as they do not support newer versions of ```nodejs``` based tools, and higher versions (5.x) do not
work yet at the moment.

The version I am currently using is v4.2.6, so that is what I would recommend (v4.2.6 or higher, but not v.5.x).

Assuming that you have all of the above installed successfully, open a terminal and "cd" into the directory where you want to install your app.

Finish the installation by entering the following commands:

<pre>
npm i && bower i
ionic state restore --plugins
</pre>

If you plan to build to a device, then you'll need to add the platforms to your local env:

<pre>
ionic platform add android
ionic platform add ios
</pre>

The project is now ready to run. To run it in a browser, type (I advise to ALWAYS use the ```-c``` option for console log):

<pre>
ionic serve -c
npm run dev
</pre>

or any other variation, e.g. (using the "labs" feature, logging to the console, and defaulting to Chrome):

<pre>
ionic serve -l -c
npm run labs
</pre>

### Some notes on usage

I've set up the gulp file and the starter app in such a way that there are essentially 3 distinct 'modes':

* 'development' mode which is what you use when running "ionic serve" (running in the browser)
* 'test' mode: used when you run 'gulp test' or 'karma start'
* 'production' mode which is what you use with "gulp build" and "ionic run" (running on a device)

As I've currently set it up, these modes are quite different.

#### Development mode

In development mode, the gulp build process is simple: no minification, concatenation etc.

By default, in development mode, the various services (signup, login etc) use a "mock" implementation with fake data
(but you can easily override this through configuration parameters).

To define configuration parameters for development mode, add them to ```src/js/config/config-dev.json```.
The ```gulp``` build process will write these values to ```src/js/config/config.js```.

#### Production mode

In production mode (used on a real device), the gulp build process does a complete build including minification, concatenation etc, and the app runs with 'real' services.

To define configuration parameters for development mode, add them to ```src/js/config/config-prod.json```.
The ```gulp``` build process will write these values to ```src/js/config/config.js```.

#### Test mode

Test mode (karma/jasmine) also uses the 'lightweight' build process and 'mock' services.

We also support end-to-end (E2E) testing, see [here](https://github.com/leob/ionic-quickstarter/wiki/E2E-Testing) for
details.

For more details on configuring and using development, test and production mode, see the
[Wiki](https://github.com/leob/ionic-quickstarter/wiki).

#### A note about using the image functionality (Cordova Camera, image cropping)

The image functionality (taking a picture, cropping a picture, and so on) only works on a device, because it needs
Cordova, and camera hardware obviously. So, you will need to use 'production mode' (that is, ```gulp build``` and
```ionic run``` or ```ionic build```).

If you do not want this, then you can change the values in the ```config-prod.json``` file, or you can change
the code of https://github.com/leob/ionic-quickstarter/blob/master/src/js/app/user/services/user.service.js (see the
explanation above).

For more details on using the image functionality, see the
[wiki](https://github.com/leob/ionic-quickstarter/wiki/Common-recipes).

#### Adding libraries

If you want to add a Javascript library (pre-made JS component) to the app, you will need to go through the following
four steps.

(example used below: the "fus-messages" component, https://github.com/fusionalliance/fus-messages)

* Install it with bower, e.g: ```bower install fus-messages --save``` (this also updates your project's
```bower.json``` file).
* Add the library path (e.g. ```'./src/lib/fus-messages/dist/fus-messages.js'```) to your ```gulp.js``` file so that
```gulp build``` knows how to copy the library file(s) during the build. You need to add it to the ```lib``` section of
the ```paths``` variable in ```gulp.js```, and normally you would choose the minified version (ending in ```.min.js```)
of the library.
* Add the library path to your project's ```index-template.html``` file inside a ```script``` tag, for instance:
  ```<script src="lib/fus-messages/dist/fus-messages.js"></script>```
* Finally, add the library's module name (e.g. ```fusionMessages```) to the list of your app dependencies inside the
```app.module``` statement in your project's ```app.js``` file.

#### Troubleshooting modulerr errors in a production build

Sometimes, after doing a production build/run (```gulp build``` followed by ```ionic build``` or ```ionic run```) you
will see nothing but a blank page when starting the app on your device.

The most common cause is that you have the infamous AngularJS 'modulerr' error. To debug and fix this, please consult
[this](https://github.com/leob/ionic-quickstarter/wiki/Troubleshooting-modulerr-errors-in-a-production-build) Wiki
page.

## Gulp file

The gulp.js file supports the following commands:

* ```gulp default``` and ```gulp watch```
* ```gulp jshint```
* ```gulp test``` and ```gulp test-single```
* ```gulp build```

Here is how you use these commands.

### Gulp default and gulp watch

Normally you don't run these commands manually. They will be executed automatically when you run ```ionic serve```.
This is done through a configuration section in the ```ionic.project``` file:

```
 "gulpStartupTasks": [
    "default",
    "watch"
 ]
```

### Gulp jshint

You can run this to hint/lint your Javascript code. Just execute:

```
gulp jshint
```

### Gulp test and gulp test-single

Use these commands to run your tests via the Karma test runner.

```gulp test``` runs the tests and then keeps watching (and re-running) them until you abort the command, while
```gulp test-single``` runs the tests only once and then exits. 

### Gulp build

You use this command to generate a production build to run on a real device. Invoke it like this:

```
gulp build
ionic run
```

Replace ```ionic run``` by ```ionic build``` if you want to perform a build instead of a run.

## Project structure

To support bigger apps, the starter app is structured differently than the basic 'tabs starter app'.

The tabs starter app lumps all the route definitions and controllers in one Javascript file, and puts the html
templates in a separate directory.

Instead, we've chosen to organize the files on a Module basis: each Module is in its own directory containing the
Javascript (controllers etc) and the HTML (templates) for that Module. This makes it easier to keep a large app
organized and maintainable.

As an example, here is the default structure (slightly simplified) after installing the starter app:

```
/
├── scss
│   └── ionic.app.scss
│
├── src
│   ├── css
│   │      
│   ├── img
│   │      
│   ├── js
│   │   ├── app
│   │   │   │
│   │   │   ├── auth
│   │   │   │   ├── forgotPassword
│   │   │   │   │   ├── forgotPassword.html
│   │   │   │   │   └── forgotPassword.js
│   │   │   │   │
│   │   │   │   ├── login
│   │   │   │   │    ├── loggedout.html
│   │   │   │   │    ├── login.html
│   │   │   │   │    ├── login.ctrl.js
│   │   │   │   │    ├── login.router.js
│   │   │   │   │    └── logout.ctrl.js
│   │   │   │   │
│   │   │   │   └── signup
│   │   │   │        ├── signup.ctrl.js
│   │   │   │        ├── signup.html
│   │   │   │        └── signup.router.js
│   │   │   │    
│   │   │   ├── user
│   │   │   │   ├── models
│   │   │   │   │   └── user.js
│   │   │   │   │       
│   │   │   │   └── services
│   │   │   │        ├── user.service.js
│   │   │   │        ├── mock
│   │   │   │        │   └── user.service.mockImpl.js
│   │   │   │      
│   │   │   app.js
│   │   │   
│   │   ├── config
│   │   │   ├── config-base.json
│   │   │   ├── config-dev.json
│   │   │   ├── config-prod.json
│   │   │   └── config.js  [GENERATED]
│   │   │   
│   │   ├── modules.js
│   │   │   
│   │   └── templates.js
│   │      
│   ├─── lib
│   │    ├── angular
│   │    ├── ionic
│   │    ├── ngCordova
│   │    └── firebase
│   │      
│   ├ index-template.html
│   └ index.html  [GENERATED]
│         
└── www
```

The structure shown above is slightly simplified, but the idea is as follows.

### Separate "src" and "www" directories

The app's sources (Javascript, HTML, CSS) sit under ```src``` instead of under the default location ```www```.

This is different than a 'standard' Ionic app, the reason is because of how the build process works.

During a production build (```gulp build```), the sources (under ```src```) are minified and concatenated and so on and
the products (build artifacts, the minified/concatenated files) are then placed in the ```www``` directory, where
Cordova (through the ```ionic run``` or ```ionic build``` process) will pick them up.

This setup keeps the sources under ```src``` cleanly separated from the build artifacts under ```www```.

### Modules

General principle: ONE DIRECTORY == ONE MODULE (and one subdirectory == 1 sub module).

So you can remove a module by removing that directory (but then you still need to remove the module reference from
app.js - the script include in index.html will be removed automatically by the build process).

Example: in the structure shown above you can see two Modules: 'app.auth' and 'app.user'.

'app.auth' has 3 sub modules: 'app.auth.login', 'app.auth.signup' and 'app.auth.forgotPassword'.

'app.user' does not have sub modules.

Each (sub)module is an AngularJS module ('angular.module(...')), and each module is in its own directory containing all
of the Javascript and HTML files making up that module.

In the example of the 'forgotPassword' module, you see that the directory contains 2 files: a template file
(forgotPassword.html) and a Javascript file (forgotPassword.js). The Javascript file contains the route definition
(UI-router $stateProvider) and the controller definition.

In the example of the 'login' module you see that the directory contains 5 files: 2 template files (login.html and
loggedOut.html) and 3 Javascript files. In this case you see that we've put the route definitions into a separate file
(login.router.js) and each of the two controllers also in separate files.

Whether or not to put the route definitions and controllers in one Javascript file or in separate files is up to you
and will probably depend on the complexity of the code ('forgotPassword' is simple enough for all the Javascript code
to be put into one file).

The 'app.user' module is a module that doesn't define controllers, routes or templates; it only contains services (and
models). However, it is perfectly possible (and often logical) to have a module that contains everything: controllers,
routes, templates, services and so on. An example of this is the 'app.mainPage' module (not shown above).

Note that during the production build process all of the separate files (Javascript and HTML) will be minified and
concatenated into one Javascript file for efficiency reasons.

**Note:** apart from the directory structure (the 1 directory == 1 module principle), we've also introduced a file
naming convention.

For instance:

Scripts defining in which controllers are defined are named 'feature.ctrl.js', where 'feature' is the name of the
feature, e.g. "login".

Scripts defining services are named 'feature.service.js', and their implementations (of any) are named
'feature.service.mockImpl.js', 'feature.service.firebaseImpl.js'.

The naming scheme is probably quite intuitive, but you can find a full explanation in the Wiki:
[Naming conventions](https://github.com/leob/ionic-quickstarter/wiki/naming-conventions).

### Services and mocks

Services which can be reused across modules are in a separate directory ```services```.

A service (for instance the UserService) can have multiple implementations, for instance a "mock" implementation and a
"Firebase" implementation. To illustrate, here is the code for userService.js:

```
angular.module('app.user')
  .factory('UserService', function ($injector, APP) {
    if (  APP.testMode) {
      return $injector.get('UserServiceMockImpl');
    } else {
      return $injector.get('UserServiceFirebaseImpl');
    }
  });
```

Depending on "flags" set in the config.js (in this case, APP.testMode), the factory instantiates either a Mock
implementation or a Firebase implementation of the user service. These implementations are in subdirectories below the
```service``` directory.

Using this approach, service implementations can easily be changed or swapped out without the client code (controllers
or other services) noticing anything.

The ability to run with 'mock' implementations makes it easy to develop quickly without having to perform a complicated
production setup, and in test mode, the mock implementations makes running your unit tests a lot faster of course.

