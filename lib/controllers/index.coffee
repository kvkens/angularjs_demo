'use strict'

path = require 'path'

###
如果view目录下面包含该html页面则返回该页面，如果不存在则返回404
###
exports.partials = (req, res) ->
  requestedView = path.join './', req.url.split('.')[0]
  res.render requestedView, (err, html) ->
    if err
      console.log "Error rendering partial'#{requestedView}' \n#{err}" 
      res.status 404
      res.send 404
    else
      res.send html

###
返回SPA主页
###
exports.index = (req, res) ->
  res.render 'index'
