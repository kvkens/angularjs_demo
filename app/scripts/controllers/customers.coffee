'use strict'

app.controller 'RoleCtrl', ($scope, DTOptionsBuilder, DTColumnBuilder) ->
	$scope.dtOptions = DTOptionsBuilder.fromSource('/api/customers/roles')
		.withBootstrap()
	$scope.dtColumns = [
		DTColumnBuilder.newColumn('role').withTitle('角色'),
		DTColumnBuilder.newColumn('create_time').withTitle('创建时间'),
		DTColumnBuilder.newColumn('operation').withTitle('操作').renderWith((data,type,full) ->
			"""
	 		<div class='visible-md visible-lg hidden-sm hidden-xs action-buttons'>
				<a class='green' title='授权' href='javascript:void(0)' onclick=customers.role.getAuth('#{full.id}') ><i class='icon-key bigger-130'></i></a>
				<a class='red' title='删除' href='javascript:void(0)' onclick=bootbox.confirm('是否要删除?',function(){}) ><i class='icon-trash bigger-130'></i></a>
			</div>
			"""
		)
	]
	return

app.controller 'PartnerCtrl', ($scope, $compile, DTOptionsBuilder, DTColumnBuilder) ->

	$scope.dtOptions = DTOptionsBuilder.fromSource('/api/customers/partners')
		.withOption('fnDrawCallback', ->
			# $compile($('.partner-name'))($scope) #动态刷新angular scope
		)
		.withBootstrap()

	$scope.dtColumns = [
		DTColumnBuilder.newColumn('name').withTitle('合作商名').renderWith( (data,type,full)-> 
			"""
			<a role='button' class='partner-name' data-toggle='modal' 
				data-target='#edit-partner-modal' 
				onclick='customers.partner.modal.edit_init(#{JSON.stringify(full)})'>
			 #{data} 
			</a>
			"""
		),
		DTColumnBuilder.newColumn('email').withTitle('邮箱'),
		DTColumnBuilder.newColumn('telephone').withTitle('联系电话'),
		DTColumnBuilder.newColumn('address').withTitle('地址'),
		DTColumnBuilder.newColumn('identifier').withTitle('标识'),
		DTColumnBuilder.newColumn('products').withTitle('订购产品').renderWith((data) -> 
			html = ""
			html += " MDM" if data.mdm
			html += " MCM" if data.mcm
			html += " MAM" if data.mam
			return html
		),
		DTColumnBuilder.newColumn('createTime').withTitle('创建时间'),
		DTColumnBuilder.newColumn('id').withTitle('操作').renderWith((data, type, full) ->
	 		"""
	 		<div class='visible-md visible-lg hidden-sm hidden-xs action-buttons'>
				<a class='blue' title='查看客户' href='javascript:void(0)' ><i class='icon-cogs bigger-130'></i></a>
				<a class='green' title='查看管理员' href='javascript:void(0)' ><i class='icon-info-sign bigger-130'></i></a>
			</div>
			"""
		)
	]
	
	return

###
用户菜单对象
###
customers = customers || {};
###角色对象###
customers.role = {};
###移植EMM角色授权代码###
customers.role.globalPerms = "";
customers.role.initPerm = (data)->
	self = this
	$.each(data,(i,n)->
		self.globalPerms += self.getPagStart(data[i].snLv,data[i].snName,data[i].id);
		if data[i].childs isnt null and data[i].childs.length isnt 0
			self.initPerm(data[i].childs);
		self.globalPerms += self.getPagEnd(data[i].snLv);
		return
	);
	return self.globalPerms
customers.role.getPagStart = (lv,name,value)->
	str = ""
	if lv == 1 
		str += '<li>'+
	      '<div class="data_tit"><label style="cursor: pointer;"><input type="checkbox" value="'+value+'" name="chkpolicy" class="vm" /> '+name+'</label></div>'+
	      '<ul class="data_child_main">';
	else if lv == 2
		str += '<li>'+
	    '<div class="data_tit"><label style="cursor: pointer;"><input type="checkbox" value="'+value+'" name="chkpolicy" class="vm" /> '+name+'</label></div>'+
	    '<ul class="data_child">';
	else if lv == 3
		str += '<li><div class="data_tit"><label style="cursor: pointer;"><input type="checkbox" value="'+value+'" name="chkpolicy" class="vm" /> '+name+'</label></div></li>';
	return str
customers.role.getPagEnd = (lv)->
	str = ""
	if lv == 3
		str = ""
	else
		str = "</ul></li>"
	return str
###
AJAX获取授权信息的页面
###
customers.role.getAuth = (id)->
	self = this
	$("#auth-role-modal").modal("show");
	$.ajax({
		type : "POST",
		url : "api/customers/roles/auth",
		data : {id:id},
		success : (msg)->
			self.globalPerms = "";
			$("#showPerm").html(self.initPerm(msg));
			#alert "查询id:" + id
			return
		error : (e)->
			alert "请求授权页面失败！"
			return
	});
	return
###合作商对象###
customers.partner = {};
###对话框操作###
customers.partner.modal = {
	add_init : ->
		$("#add-partner-modal input[name='partner.name']").val("")
		$("#add-partner-modal input[name='partner.email']").val("")
		$("#add-partner-modal input[name='partner.telephone']").val("")
		$("#add-partner-modal input[name='partner.address']").val("")
		$("#add-partner-modal input[name='partner.identifier']").val("")
		$("#add-partner-modal input[name='partner.products.mdm']").prop('checked',false)
		$("#add-partner-modal input[name='partner.products.mam']").prop('checked',false)
		$("#add-partner-modal input[name='partner.products.mcm']").prop('checked',false)
		return
	edit_init: (partner)->
		$("#edit-partner-modal input[name='partner.name']").val(partner.name)
		$("#edit-partner-modal input[name='partner.email']").val(partner.email)
		$("#edit-partner-modal input[name='partner.telephone']").val(partner.telephone)
		$("#edit-partner-modal input[name='partner.address']").val(partner.address)
		$("#edit-partner-modal input[name='partner.identifier']").val(partner.identifier)
		$("#edit-partner-modal input[name='partner.products.mdm']").prop('checked',partner.products.mdm)
		$("#edit-partner-modal input[name='partner.products.mam']").prop('checked',partner.products.mam)
		$("#edit-partner-modal input[name='partner.products.mcm']").prop('checked',partner.products.mcm)
		return
};