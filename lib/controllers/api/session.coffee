'use strict'

mongoose = require('mongoose')
passport = require('passport')

###
 * 登出
 * Passport exposes a logout() function on req (also aliased as logOut()) that can be called
 * from any route handler which needs to terminate a login session. 
 * Invoking logout() will remove the req.user property and clear the login session (if any).
###
exports.logout = (req, res) ->
  req.logOut()
  res.send 200

###
 * 登入
 * 更多信息查看 http://passportjs.org/guide/authenticate/ 中的Custom Callback章节
###
exports.login = (req, res, next) ->
  passport.authenticate('local', (err, user, info) ->
    error = err || info
    return res.json(401, error) if error
    req.logIn user, (err) ->
      return res.send(err) if err
      res.json req.user.userInfo
  )(req, res, next)
