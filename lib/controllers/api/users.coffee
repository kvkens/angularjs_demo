'use strict'

mongoose = require 'mongoose'
passport = require 'passport'

User = mongoose.model 'User'

###
 * 创建用户
###
exports.create = (req, res, next) ->
  newUser = new User(req.body)
  newUser.provider = 'local'
  newUser.save (err) ->
    return res.json(400,err) if err
    req.logIn newUser, (err) ->
      return next(err) if err
      res.json req.user.userInfo

###
 * 获取用户资料
 * 如果制定用户id，则返回对应id资料，如果未指定返回当前用户资料
###
exports.show = (req, res, next) ->
  userId = req.params.id
  if userId
    User.findById userId, (err, user) ->
      return next(err) if err
      return res.send(404) if not user
      res.send {profile: user.profile}
  else
    res.send {profile: req.user.profile} || null

###
 * 更改密码
###
exports.changePassword = (req, res, next) ->
  userId = req.user._id
  oldPass = String(req.body.oldPassword)
  newPass = String(req.body.newPassword)

  User.findById userId, (err, user) ->
    if user.authenticate oldPass
      user.password = newPass
      user.save (err) ->
        return res.send(400) if err
        res.send 200
    else
      res.send 403

###
 * 获取当前用户
###
exports.me = (req, res) -> res.json req.user || null

###
 * 获取配置信息
###
exports.config = (req, res) ->
  config = {
    user: {
      name: 'Eric Wang'
      role: 'admin'
      avatar: '/assets/avatars/user.jpg'      
    }
    company: {
      name: '企业移动管理平台'
      logo: '/images/logo.png'
    }
    menus: [
      {
        "name": "首页"
        "icon": "icon-dashboard"
        "href": "/"
      },
      {
        "name": "设置"
        "icon": "icon-laptop"
        "href": "/settings"
      },
      {
        "name": "用户"
        "icon": "icon-user"
        "href": "#"
        "submenus": [
          {
            "href": "/customers/role"
            "name": "角色管理"
          },
          {
            "href": "/customers/user"
            "name": "用户管理"
          },
          {
            "href": "/customers/source"
            "name": "资源管理"
          },
          {
            "href": "/customers/custom"
            "name": "客户管理"
          },
          {
            "href": "/customers/partner"
            "name": "合作商管理"
          },
          {
            "href": "/customers/dept"
            "name": "用户组管理"
          }
        ]
      },
      {
        "name": "内容"
        "icon": "icon-folder-open-alt"
        "href": "#"
        "submenus": [
          {
            "href": "/push"
            "name": "推送消息"
            "id": "msg_list"
          }
        ]
      }
    ]
  }
  res.json config







