'use strict'

_ = require('lodash')

module.exports = (app) ->
    require('./routes/customers')(app)
    #base route module should ALWAYS be the last one!
    require('./routes/base')(app)

