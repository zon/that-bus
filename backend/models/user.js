let _ = require('underscore')
let mongoose = require('mongoose')
let ObjectId = mongoose.Schema.Types.ObjectId

let schema = new mongoose.Schema({
	email: {type: String, trim: true},
	customerId: String,
	mergedId: ObjectId,
	created: {type: Date, default: Date.now},
	modified: {type: Date, default: Date.now}
})

schema.pre('save', (next) => {
	this.modified = Date.now()
	next()
})

let User = mongoose.model('User', schema)

User.prototype.toPublicObject = function() {
	return _.pick(this.toObject(), ['_id', 'email'])
}

module.exports = User