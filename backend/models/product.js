let mongoose = require('mongoose')

let schema = new mongoose.Schema({
	singular: String,
	plural: String,
	price: Number,
	quantity: Number,
	created: {type: Date, default: Date.now},
	modified: {type: Date, default: Date.now}
})

schema.pre('save', (next) => {
	this.modified = Date.now()
	next()
})

let Product = mongoose.model('Product', schema)

Product.setup = async function() {
	let id = "58f25bb27aabdb8f56367cfd"
	let product = await Product.findById(id)
	if (!product) {
		product = new Product({_id: id})
	}
	product.set({singular: "Ride Ticket", plural: "Ride Tickets", price: 1000, quantity: 10})
	return await product.save()
}

Product.prototype.getName = function() {
	if (this.quantity == 1) {
		return "1 "+ this.singular
	} else {
		return this.quantity +" "+ this.plural
	}
}

module.exports = Product