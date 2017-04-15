var express = require('express')
var Product = require('../models/product')

var router = express.Router()

router.get('/', async (req, res) => {
	var products = await Product.find()
	res.json(products)
})

module.exports = router