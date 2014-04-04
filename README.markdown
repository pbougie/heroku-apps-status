# Heroku Apps:Status

## Overview
[Heroku Apps:Status](https://github.com/pbougie/heroku-apps-status) is a [Heroku](https://www.heroku.com/) CLI plugin thats displays the status of each app. Possible statuses: _crashed_, _down_, _idle_, _maintenance_, _no dynos_, _starting_ or _up_.


## Install

To install the Heroku plugin:

	heroku plugins:install git://github.com/pbougie/heroku-apps-status.git


## Usage

To display the status of all apps (must not be in an app directory):

	heroku apps:status

To display the status of the current app:

	cd my-app
	heroku apps:status

To display the status of a specific remote:

	cd my-app
	heroku apps:status -r production

To display the status of any app:

    heroku apps:status --app <app_name>


## Help

To get help from the CLI:

	heroku apps:status -h


## Uninstall

To uninstall the Heroku plugin:

	heroku plugins:uninstall heroku-apps-status


## Author
[Patrick Bougie](http://patrickbougie.com/)


## Legal
Heroku Apps:Status is copyright © 2014 [Patrick Bougie](http://patrickbougie.com/). It is free software and may be redistributed under the terms specified in the LICENSE.text file.
