var path = require('path')
var fs = require('fs')

var configFile = path.normalize(__dirname +'/../config.json')

var json = {}
try {
	json = JSON.parse(fs.readFileSync(configFile, 'utf8'))
} catch (e) {
	if (e.code != 'ENOENT' || e.errno != -4058)
		throw e
}

module.exports = json