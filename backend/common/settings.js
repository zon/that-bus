var moment = require('moment')

var env = process.env.NODE_ENV

module.exports = {
	env: env,
	production: env == 'production',
	loginTokenExpiration: 0.5, // hours
	ticketExpiration: 10 // minutes
}