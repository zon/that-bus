var mongoose = require('mongoose')
var settings = require('./settings')
var config = require('./config')

var host = config.database || 'localhost'

module.exports = {

	connect: function() {
		return mongoose.connect('mongodb://'+ host +'/'+ settings.db)
	}
	
} 