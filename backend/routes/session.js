var express = require('express')
var User = require('../models/user')

var router = express.Router()

router.route('/')
	.get(async (req, res) => {
		if (!req.session || !req.session.userId) {
			let anon = await new User().save()
			req.session.userId = anon.id
			res.json(anon.toPublicObject())
		
		} else {
			let user = await User.findById(req.session.userId)
			if (user) {
				res.json(user.toPublicObject())
			
			} else {
				let anon = await new User().save()
				req.session.userId = anon.id
				res.json(anon.toPublicObject())
			}
		}
	})

module.exports = router