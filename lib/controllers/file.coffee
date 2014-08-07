'use strict'

fs = require 'fs'

path = require 'path'

exports.upload = (req, res) ->
	req.pipe(req.busboy)
	req.busboy.on 'file', (fieldname, file, filename) ->
		console.log "Uploading: " + filename
		fstream = fs.createWriteStream path.resolve(__dirname + '/../files/' + filename)
		file.pipe fstream
		fstream.on 'close', -> res.redirect('back')