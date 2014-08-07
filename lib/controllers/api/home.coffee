'use strict'

mongoose = require 'mongoose'
Thing = mongoose.model 'Thing'

###
 * Get awesome things
###
exports.awesomeThings = (req, res) -> Thing.find (err, things) -> if err then res.send(err) else res.json(things)