'use strict';

var express = require('express'),
    path = require('path'),
    fs = require('fs'),
    mongoose = require('mongoose');

/**
 * 主应用程序
 */

// 如果没有指定node环境，则设定为开发环境
process.env.NODE_ENV = process.env.NODE_ENV || 'development';

// 获取项目配置信息
var config = require('./lib/config/config');

// 定义数据库访问接口db
var db = mongoose.connect(config.mongo.uri, config.mongo.options);

// 初始化数据模型Model
var modelsPath = path.join(__dirname, 'lib/models');
fs.readdirSync(modelsPath).forEach(function (file) {
  if (/(.*)\.(js$|coffee$)/.test(file)) {
    require(modelsPath + '/' + file);
  }
});

// 如果数据库collection为空，则创建collection，构造示例数据
require('./lib/config/dummydata');

// Passport初始化配置
require('./lib/config/passport');

// Express框架
var app = express();

// Express初始化配置
require('./lib/config/express')(app);

// Express初始化路由配置
require('./lib/routes')(app);

// 启动Server
app.listen(config.port, config.ip, function () {
  console.log('Express server listening on %s:%d, in %s mode', config.ip, config.port, app.get('env'));
});

// 如果该server.js作为require的对象，则返回app
exports = module.exports = app;
