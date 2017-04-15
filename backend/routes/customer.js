var express = require('express')
var session = require('../common/session')
var stripe = require('../common/stripe')
var Product = require('../models/product')
var Ticket = require('../models/ticket')

var router = express.Router()

router.use(session.check)

router.get('/', (req, res) => {
	stripe.customers.retrieve(req.user.customerId, (err, customer) => {
		if (err) {
			console.error(err)
			res.status(402).send('Error retrieving customer.')
		} else {
			res.json(customer)
		}
	})
})

router.post('/sources', (req, res) => {
	stripe.customers.createSource(req.user.customerId, {
		source: req.body.source
	}, (err, source) => {
		if (err) {
			console.error(err)
			res.status(402).send('Error attaching source.')
		} else {
			res.status(200).end()
		}
	})
})

router.post('/default_source', (req, res) => {
	stripe.customers.update(req.user.customerId, {
		default_source: req.body.source
	}, (err, customer) => {
		if (err) {
			console.error(err)
			res.status(402).send('Error setting default source.')
		} else {
			res.status(200).end()
		}
	})
})

router.post('/charge', async (req, res) => {
	let product = await Product.findById(req.body.productId)
	if (!product) {
		res.status(402).send('Product not found.')
		return
	}

	let err = await new Promise((resolve, reject) => {
		stripe.charges.create({
			amount: product.price,
			currency: "usd",
			customer: req.user.customerId,
			source: req.body.source,
			description: product.getName()
		}, (err, charge) => {
			resolve(err)
		})
	})

	if (err) {
		console.error(err)
		res.status(402).send('Error creating charge.')
		return
	}

	for (let t = 0; t < product.quantity; t++) {
		await new Ticket({userId: req.user.id, productId: product.id}).save()
	}

	res.status(200).end()
})

module.exports = router