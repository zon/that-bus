var User = require('../models/user')

module.exports = {
	
	expand: function(req, res, next) {
		User.findById(req.session.userId).then((user, err) => {
			if (err) return next(err)	
			if (user) {
				req.user = user
				next()

			} else {
				res.unauthorized()
			}
		})
	}

}