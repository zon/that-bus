var express = require('express')
var stripe = require('../common/stripe')
var User = require('../models/user')

var router = express.Router()

async function createUser() {
	let user = new User()
	let customer = await createCustomer(user.id)
	user.customerId = customer.id
	return await user.save()
}

function createCustomer(userId) {
	return new Promise((resolve, reject) => {
		stripe.customers.create({description: userId}, (err, customer) => {
			if (err) {
				reject(err)
			} else {
				resolve(customer)
			}
		})
	})
}

router.route('/')
	.get(async (req, res) => {
		if (!req.session || !req.session.userId) {
			let user = await createUser()
			req.session.userId = user.id
			res.json(user.toPublicObject())
		
		} else {
			let user = await User.findById(req.session.userId)
			if (user) {
				res.json(user.toPublicObject())
			
			} else {
				let user = await createUser()
				req.session.userId = user.id
				res.json(user.toPublicObject())
			}
		}
	})

module.exports = router