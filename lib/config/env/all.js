'use strict';

var path = require('path');

var rootPath = path.normalize(__dirname + '/../../..');

module.exports = {
  root: rootPath, //定义root路径
  port: process.env.PORT || 9000, //定位server端口，没有指定的话为9000
  //mongodb配置选项
  mongo: {
    options: {
      db: {
        safe: true
      }
    }
  }
};