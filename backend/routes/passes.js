var express = require('express')
var session = require('../common/session')
var Pass = require('../models/pass')

var router = express.Router()

router.use(session.check)

router.get('/', async (req, res) => {
	var passes = await Pass.find({ $or: [
		{userId: req.user.id, expired: {$exists: false}},
		{userId: req.user.id, expired: {$gt: Date.now()}}
	]})
	res.json(passes)
})

module.exports = router