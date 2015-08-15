An ultra lightweight way of setting up a standard application runtime environment by pulling in and initializing core dependencies in a well-defined manner without having to repeat yourself.

## Motivation

After writing a few applications you'll usually identify a few best practice patterns for other apps.
Just like a package manager manages dependencies, kickstarting does the same for services.

Applications are made of multiple components


This basic module starts out with configuration (`nconf`) and logging (`bunyan`).

* nconf
* bunyan
* logger instance
* startup / shutdown messages
* package info (`package.json`)

Other optional packages may supply a web server, persistence, caching, etc.

Surely quite customized to my needs but maybe serves others as a template.

Still needs a bit more documentation love, so use with care. It’s currently primarily intended for my own use.