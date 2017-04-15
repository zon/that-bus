var moment = require('moment')
var express = require('express')
var settings = require('../common/settings')
var session = require('../common/session')
var Ticket = require('../models/ticket')

var router = express.Router()

router.use(session.check)

router.get('/', async (req, res) => {
	var tickets = await Ticket.find({ $or: [
		{userId: req.user.id, expires: {$exists: false}},
		{userId: req.user.id, expires: {$gt: Date.now()}}
	]})
	res.json(tickets)
})

router.post('/activate', async (req, res) => {
	var expires = moment().add(settings.ticketExpiration, 'minutes')
	var ticket = await Ticket.findOneAndUpdate(
		{userId: req.user.id, expires: {$exists: false}},
		{$set: {expires: expires}},
		{new: true}
	)
	if (ticket) {
		res.json(ticket)
	} else {
		res.badRequest('No ticket available.')
	}
})

module.exports = router