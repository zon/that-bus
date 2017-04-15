var express = require('express')
var bodyParser = require('body-parser')
var cookieParser = require('cookie-parser')
var expressSession = require('express-session')
var RedisStore = require('connect-redis')(expressSession)

var settings = require('./common/settings')
var config = require('./common/config')
var db = require('./common/db')

db.connect()

var app = express()

app.use(bodyParser.json({limit: '10mb'}))
app.use(cookieParser(settings.cookieSecret))
app.use(expressSession({
	secret: settings.cookieSecret,
	cookie: {maxAge: 3600*24*365*10},
	store: new RedisStore({
		host: settings.redis.host,
		port: settings.redis.port
	}),
	resave: false,
	saveUninitialized: false
}))

app.use((req, res, next) => {

	res.badRequest = function(msg) {
		res.status(400).json(msg || "Bad request")
	}
	res.unauthorized = function(msg) {
		res.status(401).json(msg || "Unauthorized")
	}
	res.forbidden = function(msg) {
		res.status(403).json(msg || "Forbidden")
	}
	res.notFound = function(msg) {
		res.status(404).json(msg || "Not found")
	}

	next()
})

app.use((req, res, next) => {
	console.log(req.method +" "+ req.url)
	next()
})

app.use('/products', require('./routes/products'))
app.use('/session', require('./routes/session'))
app.use('/customer', require('./routes/customer'))

app.use((req, res) => {
	res.notFound('Not found!')
})

app.listen(8080, () => {
	console.log('Listening on 8080.')
})