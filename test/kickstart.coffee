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

  it 'can `use` packages declared in the ’uses’ option ',->
    mockery = require 'mockery'
    fakeModule = (env)->
      env.fake = 'fake'
      return env

    anotherFakeModule = (env)->
      env.anotherFake = "another #{env.fake}"
      return env

    path = require 'path'
    mockery.enable();
    mockery.registerAllowables ['../','path',path.resolve "#{__dirname}/../package.json"]
    mockery.registerMock 'kickstart-fake', fakeModule
    mockery.registerMock 'kickstart-anotherFake', anotherFakeModule
    env = require('../')(uses:'fake anotherFake')
    assert.deepEqual env.fake, 'fake'
    assert.deepEqual env.anotherFake, 'another fake'
    mockery.disable();