var path = require('path')
var fs = require('fs')

var localhost = '127.0.0.1'

var defaults = {
	databaseHost: localhost,
	databasePort: 27017,
	databaseName: 'buspass',
	redisHost: localhost,
	redisPort: 6379,
	cookieSecret: "hq60r2v7zqzkwe3559h8xc19j8z1osba",
	stripeSecretKey: "sk_test_CWNUTLjUEjGqXil8FzdyqqyW"
}

var config = {}
var configFile = path.normalize(__dirname +'/../config.json')
try {
	config = JSON.parse(fs.readFileSync(configFile, 'utf8'))
} catch (e) {
	if (e.code != 'ENOENT' || e.errno != -4058)
		throw e
}

config = Object.assign(defaults, config)

config.databaseHost = process.env.DATABASE_HOST || config.databaseHost
config.redisHost = process.env.REDIS_HOST || config.redisHost
config.cookieSecret = process.env.COOKIE_SECRET || config.cookieSecret
config.stripeSecretKey = process.env.STRIPE_SECRET_KEY || config.stripeSecretKey

module.exports = config