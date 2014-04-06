# Heroku Apps:Status

## Overview
[Heroku Apps:Status](https://github.com/pbougie/heroku-apps-status) is a [Heroku](https://www.heroku.com/) CLI plugin thats displays the status of your apps. Possible statuses: _crashed_, _down_, _idle_, _maintenance_, _no dynos_, _starting_ or _up_.


## Install

To install the Heroku plugin:

	$ heroku plugins:install git://github.com/pbougie/heroku-apps-status.git
	Installing heroku-apps-status... done


## Usage

To display the status of all apps (must not be in an app directory):

	$ heroku apps:status
	=== Apps Status
	my-first-app: up
	my-second-app: idle
	my-third-app: maintenance
	my-fourth-app: no dynos

To display the status of the current app:

	$ cd my-app
	$ heroku apps:status
	=== Apps Status
	my-app: up

To display the status of a specific remote:

	$ cd my-app
	$ heroku apps:status -r production
	=== Apps Status
	my-app: up

To display the status of any app:

    $ heroku apps:status --app <app_name>
	=== Apps Status
	<app_name>: up    


## Help

To get help from the CLI:

	$ heroku apps:status -h
	Usage: heroku apps:status [--app APP]
	...


## Uninstall

To uninstall the Heroku plugin:

	$ heroku plugins:uninstall heroku-apps-status
	Uninstalling heroku-apps-status... done


## Author
[Patrick Bougie](http://patrickbougie.com/)


## Legal
Heroku Apps:Status is copyright © 2014 [Patrick Bougie](http://patrickbougie.com/). It is free software and may be redistributed under the terms specified in the LICENSE.text file.
