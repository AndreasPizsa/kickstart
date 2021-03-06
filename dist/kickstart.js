// Generated by CoffeeScript 1.8.0
(function() {
  var _;

  _ = require('lodash');

  module.exports = function(options) {
    var array, env, mod, name, params, path, pkgname, _i, _len, _ref;
    env = _.extend({
      _: _
    }, options);
    path = require('path');
    if (env.rootDir == null) {
      env.rootDir = path.dirname(require.main.filename);
    }
    console.log(env.rootDir);
    env.rootDir = env.rootDir.replace(/\/node_modules\/.*/, '');
    pkgname = path.resolve(env.rootDir, './package.json');
    env.pkginfo = require(pkgname);
    env.use = function(name, options) {
      console.log(name, options);
      return _.extend({}, require(name)(env, options), env);
    };
    env.uses = env.uses || {};
    if (_.isString(env.uses)) {
      env.uses = env.uses.split(/\s+/);
    }
    if (_.isArray(env.uses)) {
      array = env.uses;
      env.uses = {};
      for (_i = 0, _len = array.length; _i < _len; _i++) {
        name = array[_i];
        env.uses[name] = {};
      }
    }
    _ref = env.uses;
    for (mod in _ref) {
      params = _ref[mod];
      env = env.use("kickstart-" + mod, params);
    }
    return env;
  };

}).call(this);
