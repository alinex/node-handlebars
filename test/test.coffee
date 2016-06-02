chai = require 'chai'
chai.use require 'chai-datetime'
expect = chai.expect

handlebars = require 'handlebars'
require('../src/index').register handlebars

exports.equal = (template, data, goal) ->
  fn = handlebars.compile template
  result = fn data
  expect(result).to.equal goal

exports.contain = (template, data, goal) ->
  fn = handlebars.compile template
  result = fn data
  expect(result).to.contain goal
