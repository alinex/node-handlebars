# Domain name validation
# =================================================

# Check options:
#
# - `optional` - the value must not be present (will return null)


# Node modules
# -------------------------------------------------
moment = null # load if needed
chrono = null # load on demand
numeral = null # load on demand
math = null # load if needed
# alinex modules
util = require 'alinex-util'


initMoment = ->
  return if moment
  moment = require 'moment'
  chrono ?= require 'chrono-node'
  moment.createFromInputFallback = (config) ->
    config._d = switch config._i.toLowerCase()
      when 'now' then new Date()
      else chrono.parseDate config._i


# Handlebars Helper
# -------------------------------------------------

# ### Get arguments
# - name - name of the function
# - args - the normal parameters
# - hash - named parameters
# - fn - content function in block helpers
# - inverse - else part of block helpers
# - data - current context
argParse = (args) ->
  args = [].slice.call(args)
  options = args[args.length-1]
  options.args = args[0..-2]
  options.data = options.data.root
  options

helper =

  # ### Comparison

  is: ->
    {args, fn, inverse, data} = argParse arguments
    if args.length is 2
      [left, right] = args
      operator = '=='
    else
      [left, operator, right] = args
    # use count of entries for array
    if typeof left is 'object'
      left = Object.keys(left).length
    # call comparison
    result = switch operator
      when '>' then left > right
      when '<' then left < right
      when '>=' then left >= right
      when '<=' then left <= right
      when '==' then left is right
      when 'not', '!=' then left isnt right
      when 'in'
        right = right.split /\s*,\s*/ unless Array.isArray right
        ~right.indexOf left
      when '!in'
        right = right.split /\s*,\s*/ unless Array.isArray right
        not ~right.indexOf left
      else left
    # execute content or else part
    if result then fn data else inverse data

  # ### String

  lowercase: ->
    {args} = argParse arguments
    args[0].toLowerCase()

  uppercase: ->
    {args} = argParse arguments
    args[0].toUpperCase()

  capitalizeFirst: ->
    {args} = argParse arguments
    args[0].charAt(0).toUpperCase() + args[0].slice(1)

  capitalizeEach: ->
    {args} = argParse arguments
    args[0].replace /\w\S*/g, (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1)

  shorten: ->
    {args} = argParse arguments
    [text, len] = args
    util.string.shorten text, len


  # ### Format

  # format an ISO date using Moment.js - http://momentjs.com/
  #
  #     date = new Date()
  #     {{dateFormat date "MMMM YYYY"}}
  #     # January 2016
  #     {{dateFormat date "LL"}}
  #     # January 18, 2016
  #     {{#dateFormat "LL"}}2016-01-18{{/dateFormat}}
  #     # January 18, 2016
  format: ->
    {args, fn, data} = argParse arguments
    if fn
      obj = fn data
      [format, locale] = args
    else
      [obj, format, locale] = args
    # format date
    initMoment()
    m = moment obj
    if m.isValid()
      m.locale locale if locale
      return m.format format ? 'MMM Do, YYYY'
    # format numbers
    if format
      numeral ?= require 'numeral'
      if locale
        try
          numeral.language locale, require "numeral/languages/#{locale}"
          numeral.language locale
      obj = numeral(obj).format format
      numeral.language 'en' if locale
    obj

  unit: ->
    {args, fn, data} = argParse arguments
    if fn
      num = fn data
      [from, to, format, locale] = args
    else
      [num, from, to, format, locale] = args
    format ?= '0.00'
    # change unit
    math ?= require 'mathjs'
    num = "#{num}#{from}" if from
    value = math.unit num
    value = value.to to if to
    value = value.format()
    # format value
    numeral ?= require 'numeral'
    if locale
      try
        numeral.language locale, require "numeral/languages/#{locale}"
        numeral.language locale
    [v, p] = value.split /[ ]/
    value = numeral(v).format(format) + ' ' + p
    numeral.language 'en' if locale
    value

  # ### Math helper

  # ### dateAdd
  #
  # Add interval to date.
  #
  #     date = new Date()
  #     {{dateAdd date 1 "month"}}
  #     {{#dateAdd 1 "month"}}2016-01-18{{/dateAdd}}
  dateAdd: ->
    {args, fn} = argParse arguments
    if fn
      date = fn this
      [count, interval] = args
    else
      [date, count, interval] = args
    # calculate date
    moment ?= require 'moment'
    moment new Date date
    .add count, interval
    .toDate()

  # ### Array

  index: ->
    {args} = argParse arguments
    [list, i, j] = args
    i = if i is -1 then list.length -1 else i ? 0
    j ?= i
    list[i..j]

  withIndex: ->
    {args, fn, data} = argParse arguments
    [list, i, j] = args
    i = if i is -1 then list.length -1 else i ? 0
    j ?= i
    list[i..j].map (e) -> fn e
    .join ''

#Swag.addHelper 'join', (array, separator) ->
#    array.join if Utils.isUndefined(separator) then ' ' else separator
#, 'array'
#
#Swag.addHelper 'length', (array) ->
#    array.length
#, 'array'
#
#Swag.addHelper 'eachIndex', (array, options) ->
#    result = ''
#
#    for value, index in array
#        result += options.fn item: value, index: index
#
#    result
#, 'array'
#
#  # ### Object
#
#Swag.addHelper 'eachProperty', (obj, options) ->
#    result = ''
#
#    for key, value of obj
#        result += options.fn key: key, value: value
#
#    result
#, 'object'
#



# Register Helper Methods
# ----------------------------------------------------------------
exports.register = (handlebars) ->
  # register helper
  for key, fn of helper
    handlebars.registerHelper key, fn
