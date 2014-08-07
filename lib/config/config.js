'use strict';

var _ = require('lodash');

/**
 * 载入环境配置文件
 */
module.exports = _.merge(
	//env/all.js为generall的配置文件
    require('./env/all.js'),
    //根据process.env.NODE_ENV来载入对应node执行环境的配置文件，默认为开发环境配置文件
    require('./env/' + process.env.NODE_ENV + '.js') || {});