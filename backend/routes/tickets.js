var express = require('express')
var session = require('../common/session')
var Ticket = require('../models/ticket')

var router = express.Router()

router.use(session.check)

router.get('/', async (req, res) => {
	var tickets = await Ticket.find({ $or: [
		{userId: req.user.id, expired: {$exists: false}},
		{userId: req.user.id, expired: {$gt: Date.now()}}
	]})
	res.json(tickets)
})

module.exports = router