'use strict'

customers = require '../controllers/api/customers'

module.exports = (app) ->
  app.route('/api/customers/roles')
    .get(customers.roles.list)
  app.route('/api/customers/roles/auth')
  	.post(customers.roles.auth).get(customers.roles.auth)
  app.route('/api/customers/partners')
    .get(customers.partners)

