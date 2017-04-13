var moment = require('moment')
var config = require('./config')

var env = process.env.NODE_ENV

module.exports = {
	env: env,
	production: env == 'production',
	db: 'buspass',
	redis: {
		host: config.redisHost || '127.0.0.1',
		port: config.redisPort || 6379
	},
	cookieSecret: 'hq60r2v7zqzkwe3559h8xc19j8z1osba',
	loginTokenExpiration: 0.5, // hours
}