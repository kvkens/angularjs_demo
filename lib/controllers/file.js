// Generated by CoffeeScript 1.7.1
'use strict';
var fs, path;

fs = require('fs');

path = require('path');

exports.upload = function(req, res) {
  req.pipe(req.busboy);
  return req.busboy.on('file', function(fieldname, file, filename) {
    var fstream;
    console.log("Uploading: " + filename);
    fstream = fs.createWriteStream(path.resolve(__dirname + '/../files/' + filename));
    file.pipe(fstream);
    return fstream.on('close', function() {
      return res.redirect('back');
    });
  });
};