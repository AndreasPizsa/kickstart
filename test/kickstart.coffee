assert = require 'assert'

describe 'kickstart',->
  env = null

  before ->
    env = require('../')()

  it 'exports rootDir',->
    assert.ok env.rootDir?

  it 'exports pkginfo',->
    assert.ok env.pkginfo?

  it 'exports the correct default pkginfo',->
    assert.deepEqual require('../package.json'), env.pkginfo

  it 'exports the correct pkginfo with a custom rootDir',->
    env = require('../') rootDir: __dirname
    assert.deepEqual require('./package.json'), env.pkginfo