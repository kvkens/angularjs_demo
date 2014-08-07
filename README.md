emm_frontend
============

CoffeeScript + AngularJS + Express + Karma + Mongoose + Passport + KISSY + ACE


---

### 1. 背景，为什么要这么搞

*   设计 --- 前端(接口) --- 测试(测试用例并且完善接口文档) --> 后台(Model 开发)
*   设计 --- 前端 --- 后台

---

### 2. 项目中使用的技术

按照`*`来标注技术或者工具的重要等级。

`***`为最重要，`*`为需要但不是特别重要，没有`*`的表示可以不掌握，但是推荐掌握的内容。

*   通用
    *   Github(SourceTree) \*\*\*
    *   Sublime Text2 \*\*
    *   CoffeeScript \*\*
    *   RESTful API \*\*
    *   MVC\*
    *   goAgent\*
    *   Markdown
*   前端
    *   AngularJS \*\*\*
    *   JQuery \*\*\*
    *   Bootstrap \*\*
    *   ACE Template \*\*
    *   KISSY \*
    *   Sea.js
*   后端
    *   NodeJS  \*\*\*
    *   express \*\*
    *   mongoDB(Mongoose) \*
    *   passport \*
    *   npm \*
    *   Bower \*
    *   Grunt \*
*   测试
    *   Karma
    *   Jasmine

---

### 3. Installation

#### Under Windows

*   安装[nodeJS](http://nodejs.org/)
*   安装[MongoDB](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-windows/)(注：需要设置dbpath)
*   安装[Github for Windows](https://windows.github.com/)
*   安装[SourceTree](http://www.sourcetreeapp.com/)(optional)
*   安装[goAgent](http://poly.emptystack.net/emm/goagent/)
*   安装`npm install -g bower-cli`
*   将项目fork到本地，并进入项目根目录
*   执行`npm install`安装所需要的工具文件(鉴于国内网络，建议使用代理，具体执行方式为打开goAgent并执行`npm install --proxy http://127.0.0.1:8087`)
*   执行`bower install`安装前端所需库

#### Under Mac

*   安装[NodeJS](http://nodejs.org/)
*   安装[MongoDB](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-os-x/)
*   安装[Github for MAC](https://mac.github.com/)
*   安装[SourceTree](http://www.sourcetreeapp.com/)(optional)
*   安装[goAgent](http://poly.emptystack.net/emm/goagent/)
*   将项目fork到本地，并进入项目根目录
*   执行`npm install`安装所需要的工具文件(鉴于国内网络，建议使用代理，具体执行方式为打开goAgent并执行`npm install --proxy http://127.0.0.1:8087`)
*   执行`bower install`安装前端所需库

---

### 4. 运行

*   执行`mongod`来启动mongodb
*   进入项目根目录
*   执行`sudo grunt serve`启动项目

### 5. 项目结构

```bash
.
├── Gruntfile.js            #Grunt的配置文件
├── app                     #前端项目base目录
│   ├── assets              #资源文件(ACE等)
│   ├── bower_components    #bower install下载的库资源
│   ├── favicon.ico         #图标
│   ├── fonts               #字体
│   ├── images              #图片
│   ├── robots.txt          #用于搜索引擎爬虫进行识别的文件
│   ├── scripts             #脚本
│   │   ├── app.coffee      #前端程序入口
│   │   ├── controllers     #Angular Controller
│   │   ├── directives      #Angular Directives
│   │   └── services        #Angular Services
│   ├── styles              #样式
│   └── views               #视图
├── bower.json              #Bower配置文件
├── lib                     #后台NodeJS服务器端base目录
│   ├── config              #配置文件存放在这里
│   ├── controllers         #Controller
│   ├── models              #Model
│   ├── routes              #路由模块，用来控制请求的处理
│   ├── middleware.coffee   #用于定义自定义中间件
│   ├── routes.coffee       #总路由管理文件
├── node_modules            #npm安装的工具存放目录
├── package.json            #npm配置文件
├── server.js               #后台NodeJS服务器端入口
└── test                    #测试模块base目录
```

### 6. 项目约定

####前端约定：

1.  因为AngularJS双向数据绑定性能开销比较大，因此在类似于表格等可能存在较多item的场景下尽量少使用AngularJS的双向绑定。
2.  按照模块进行划分，比如说Customer则对应一个customer.coffee。而隶属于Customer模块的User子模块对应的Controller写在`controller/customer.coffee`下。
3.  `onReady`的js代码必须写在view目录下的html页面里。
4.  所有定义的函数和属性必须写在controller里面，并且加上对应的域。比如说Custmer下的User里面有一个函数叫做`create`，则函数定义应该为`customer.user.create = function(){balabala....}`

####后端约定：

1.  构造假数据可以直接在controller里面构造，也可以构造`.json`文件作为假数据的请求。
2.  Route请求规则请参考现有模块进行构造。

###To be continued。。。

