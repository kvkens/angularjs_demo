'use strict'

app = angular.module 'emmFrontendApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'datatables',
  'ngStorage'
  ]

############################Route Module#################################

###
 * Customer Route
###
app.config ($routeProvider) ->
  $routeProvider
    .when('/customers/role',{
      templateUrl: 'partials/customers/role'
      controller: 'SettingsCtrl'
      authenticate: true
      })
    .when('/customers/partner',{
      templateUrl: 'partials/customers/partner'
      controller: 'PartnerCtrl'
      authenticate: true
      })  

###
 * Base Route
###
app.config ($routeProvider) ->
  $routeProvider
    .when('/login',{
      templateUrl: 'partials/login'
      controller: 'LoginCtrl'
      authenticate: false
      })
    .when('/signup',{
      templateUrl: 'partials/signup'
      controller: 'SignupCtrl'
      })
    .when('/settings',{
      templateUrl: 'partials/settings'
      controller: 'SettingsCtrl'
      authenticate: true
      })
    .when('/',{
      templateUrl: 'partials/main'
      controller: 'MainCtrl',
      authenticate: true
      })
    .otherwise({
      redirectTo: '/'
      })

############################Route Module Done#################################

###
 * Other Configuration
 * $locationProvider: 用于配置angularJS中的deep link路径的存储格式。 包含hashPrefix和html5Mode属性
 * $httpProvider: 用于进行$http的配置
###
app.config ($locationProvider ,$httpProvider) ->

  $locationProvider.html5Mode true

  ###
   * 当server端返回401错误的时候重定向到/login登陆页面
  ###
  $httpProvider.interceptors.push ['$q','$location', ($q, $location) ->
    {
      responseError: (response) ->
        $location.path '/login' if response.status is 401
        $q.reject(response)
    }
  ]

###
 * Initialization
###

app.run ($rootScope, $location, $http, Auth, $DTDefaultOptions, $sessionStorage) ->

  ###
   * 默认左侧侧导航栏为打开状态
  ###
  ace.settings.sidebar_collapsed(false)
  
  ###
   * 如果用户登陆，则发送/api/user/config请求来获取用户基础配置信息
   * 如果用户没登陆，则将配置信息清空
  ###
  if Auth.isLoggedIn()
    if $sessionStorage.config?
      $rootScope.config = $sessionStorage.config
    else
      $http({
        method:'GET'
        url: '/api/user/config'
      }).success((data, status, headers, config) ->
        $sessionStorage.config = data
        $rootScope.config = data
      ).error((data, status, headers, config) ->
        alert '/api/user/config error'
      )
  else
    $sessionStorage.$reset() if $sessionStorage.config?
    $rootScope.config = {
      user:{}
      company:{}
      menus:{}
    }

  ###
   * 配置datatables
  ###
  oLanguage = {
    "sLengthMenu": "每页显示 _MENU_ 条记录",
    "sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
    "sInfoEmpty": "没有数据",
    "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
    "oPaginate": {
      "sFirst": "首页",
      "sPrevious": "前一页",
      "sNext": "后一页",
      "sLast": "尾页",
    },
    "sSearch": "搜索: ",
    "sZeroRecords": "没有检索到数据",
    "sProcessing": "<img src='./loading.gif' />"
  }
  $DTDefaultOptions.setLanguage(oLanguage)

  ###
   * 监听route地址的变化，如果route地址需要权限验证，而又未登录，则跳转至login登陆页面
  ###
  $rootScope.$on '$routeChangeStart', (event, next) ->
    url = $location.url()
    url = url.substr(0,url.indexOf('?')) if url.indexOf('?') > -1

    $location.path('/login') if next.authenticate and not Auth.isLoggedIn()
    $rootScope.url = url
    if Auth.isLoggedIn() and not $sessionStorage.config?
      console.log 123
      $http({
        method:'GET'
        url: '/api/user/config'
      }).success((data, status, headers, config) ->
        $sessionStorage.config = data
        $rootScope.config = data
      ).error((data, status, headers, config) ->
        alert '/api/user/config error'
      )      
    if not Auth.isLoggedIn()
      $sessionStorage.$reset() if $sessionStorage.config?
      $rootScope.config = {
        user:{}
        company:{}
        menus:{}
      }
    return

# ###
#  * KISSY初始化
# ###
# KISSY.ready (S) ->
#   console.log 'Kissy Initialization'
#   KISSY.config 'combine',false

# ###
#  * 上传文件插件示例
# ###
# KISSY.use """
#   gallery/uploader/1.5/index,
#   gallery/uploader/1.5/themes/default/index,
#   gallery/uploader/1.5/themes/default/style.css
#   """, (S, Uploader, DefaultTheme) ->
#   KISSY.use """
#     gallery/uploader/1.5/plugins/auth/auth,
#     gallery/uploader/1.5/plugins/urlsInput/urlsInput,
#     gallery/uploader/1.5/plugins/proBars/proBars  
#     """, (S, Auth, UrlsInput, ProBars) ->
#     uploader = new Uploader '#J_UploaderBtn', {action: '/file/upload'}
#     uploader.theme(new DefaultTheme {queueTarget: '#J_UploaderQueue'})
#     uploader.plug(new Auth {max:3,maxSize:10240}).plug(new UrlsInput {target: '#J_Urls'}).plug(new ProBars())





