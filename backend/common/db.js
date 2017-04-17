var mongoose = require('mongoose')
var settings = require('./settings')
var config = require('./config')

var Product = require('../models/product')

mongoose.Promise = global.Promise

module.exports = {

	connect: function() {
		mongoose.connect('mongodb://'+ config.databaseHost +':'+ config.databasePort +'/'+ config.databaseName)

		Product.setup()
	}
	
} 