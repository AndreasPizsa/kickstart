# Startup
Reusable modules for various startup tasks

    _ = require 'lodash'

    module.exports = (options)->
      env = _.extend {_:_},options

      path        = require 'path'
      rootModule  = module
      rootModule  = rootModule.parent while rootModule.parent
      env.rootDir = path.dirname rootModule.filename
      pkgname     = path.join env.rootDir, 'package.json'
      env.pkginfo = require pkgname

      env.use = (name)-> _.extend {},require(name)(env),env

## Load any other initialization modules
Applications can pass the names other "modules" in the `env.uses` parameters. These modules will be loaded and initialized in the same way we did before. The `env` is passed along to all other modules, and each modules return values will be added to `env`.

      env.uses = env.uses.split(' ') if _.isString env.uses
      env.uses = [env.uses] if not _.isArray env.uses
      env = env.use "kickstart-#{mod}" for mod in env.uses
      return env