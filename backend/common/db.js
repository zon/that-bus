var mongoose = require('mongoose')
var settings = require('./settings')
var config = require('./config')

var Product = require('../models/product')

mongoose.Promise = global.Promise

var host = config.database || 'localhost'

module.exports = {

	connect: function() {
		mongoose.connect('mongodb://'+ host +'/'+ settings.db)

		Product.setup()
	}
	
} 