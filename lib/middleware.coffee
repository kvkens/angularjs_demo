'use strict'

###
 * 用于应用的自定义中间件
###
module.exports = {

  ###
   *  可以用于做API的访问权限验证
  ###
  auth: (req, res, next) ->
    return next() if req.isAuthenticated()
    res.send(401)


  ###
   * Set a cookie for angular so it knows we have an http session
  ###
  setUserCookie: (req, res, next) ->
    res.cookie 'user', JSON.stringify(req.user.userInfo) if req.user
    next()
}