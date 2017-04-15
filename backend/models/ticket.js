let mongoose = require('mongoose')
let ObjectId = mongoose.Schema.Types.ObjectId

let schema = new mongoose.Schema({
	userId: ObjectId,
	productId: ObjectId,
	expires: Date,
	created: {type: Date, default: Date.now},
	modified: {type: Date, default: Date.now}
})

schema.pre('save', (next) => {
	this.modified = Date.now()
	next()
})

let Ticket = mongoose.model('Ticket', schema)

module.exports = Ticket