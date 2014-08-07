'use strict'

home = require '../controllers/api/home'
users = require '../controllers/api/users'
session = require '../controllers/api/session'
middleware = require '../middleware'
index = require '../controllers/index'
file = require '../controllers/file'

###
 * 应用路由配置
###
module.exports = (app) ->

  ###
   * 服务端 API 路由
  ###
  app.route('/api/session')
    .post(session.login)
    .delete(session.logout)
  app.route('/api/users')
    .post(users.create)
    .put(users.changePassword)
    .get(users.show)
  app.route('/api/users/me')
    .get(users.me)
  app.route('/api/users/:id')
    .get(users.show)
  app.route('/api/user/config')
    .get(users.config)
  ###
   * 示例url
  ###
  app.route('/api/home/awesomeThings')
    .get(home.awesomeThings)

  ###
   * 示例文件上传
  ###
  app.route('/file/upload')
    .post(file.upload)

  ###
   * 所有未定义的api路由都应该返回404错误
   * api主要是在页面中进行异步请求调用，不能直接跳转到初始页面
  ###
  app.route('/api/*')
    .get( (req,res) -> res.send(404))

  ###
   * 对于angular route进行渲染的view给予放行，但是需要统一在/partials/下
  ###
  app.route('/partials/*')
    .get(index.partials)

  app.route('/test')
    .get((req, res)-> res.render 'test')
  ###
   * SPA主页路由
  ###
  app.route('/*')
    .get(middleware.setUserCookie, index.index)