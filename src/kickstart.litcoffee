# Startup
Reusable modules for various startup tasks

    _ = require 'lodash'

    module.exports = (options)->
      env  = _.extend {_:_},options
      path = require 'path'

## `rootDir`
It should not be necessary to pass `rootDir` in `options`, but it’s supported
here for edge cases.

      unless env.rootDir?
        env.rootDir = path.dirname require.main.filename

When running under a testing environment such as `mocha`, `require.main` will
point to mocha instead of our app. Let’s correct this. We're using a very basic
strategy for now; future strategies might include getting our own parent etc.

        env.rootDir = env.rootDir.replace /\/node_modules\/.*/,''

## `pkgname`

      pkgname     = path.resolve env.rootDir, './package.json'
      env.pkginfo = require pkgname

## Loading kickstart modules
Applications can pass the names of other "modules" in the `env.uses` parameters.
These modules will be loaded and initialized with the accumulated `environment`
from its predecessors: `env` is passed along to all other modules, and each
module’s return values will be added to `env`.

As a rule, modules can not "overwrite" existing environment variables.

## `use`

      env.use = (name)-> _.extend {},require(name)(env),env

## `uses`

      env.uses = env.uses || []
      env.uses = env.uses.split(' ') if _.isString env.uses
      env.uses = [env.uses] if not _.isArray env.uses
      env = env.use "kickstart-#{mod}" for mod in env.uses

      return env