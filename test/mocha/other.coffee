test = require '../test'
### eslint-env node, mocha ###

describe "other helper", ->

  describe "include", ->

    it "should add local file", ->
      test.contain '{{include "/proc/cpuinfo"}}', null, 'processor'
