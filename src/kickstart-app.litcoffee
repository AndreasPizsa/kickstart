# Start an App

Things I do in every app.

* nconf
* bunyan
* logger instance
* startup / shutdown messages
* package info

Surely quite customized to my needs but may serve others as a template.

## Setup the Runtime Environment

    require_optional = (modulename,defaults={})->
      try
        return require modulename
      catch e
        return defaults

    module.exports = (options)->
      {_,pkginfo} = options

      runtimeEnvironment = process.env.NODE_ENV ? 'development'

      path  = require 'path'
      nconf = require 'nconf'
      nconf
        .argv()
        .file( file: path.join options.baseDir, "config/#{runtimeEnvironment}.json" )
        .env()
        .defaults( _.extend {
            PORT      : 3000
            NODE_ENV  : 'development'
        },require_optional(path.join options.baseDir, 'config/defaults'),
          require_optional(path.join options.baseDir, "config/#{runtimeEnvironment}"))

## Saying „Hello“
Like every good person, we introduce ourselves when we arrive, we say goodbye when we leave and we apologize if we do something wrong.

      bunyan = require 'bunyan'
      log = bunyan.createLogger
        name : "#{pkginfo.name} #{pkginfo.version}"
        serializers: bunyan.stdSerializers

      log.info
        name    : pkginfo.name
        version : pkginfo.version
        node_env: nconf.get 'NODE_ENV'
      , "Application started"

      (require 'exit-hook') ()->
        log.info
          name    : pkginfo.name
          version : pkginfo.version
          uptime  : process.uptime()
        , 'Application terminating.'

      process.on 'uncaughtException',(err)->
        console.log 'uncaughtException ' + JSON.stringify err
        log.fatal { err: err}, 'uncaughtException'

      return env =
        nconf   : nconf
        bunyan  : bunyan
        log     : log
