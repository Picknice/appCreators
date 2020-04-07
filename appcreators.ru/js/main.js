var Profile, Token = data('token'), ApiHost = 'https://api.appcreators.ru', Title = 'Панель управления';
var Renders = {
	history: function(item){
		return '<tr item-id="'+item.id+'"><td>('+(item.user.admin?(item.user.super?'Супер администратор':(item.user.support?'Техническая поддержка':'Администратор')):'Пользователь')+') <b>'+(item.user.phone!=undefined?item.user.phone:item.user.login)+'</b> '+item.text[0].toLowerCase()+item.text.substring(1)+' <i class="far fa-clock cli"></i> '+timepassed(item.created)+'<br></td></tr>';
	},
	admin: function(item, onlySupers){
		onlySupers = onlySupers === true ? true : false;
		return '<tr admin-id="'+item.id+'"><td class="td">'+item.id+'</td><td class="td">'+item.login+(Profile&&Profile.login==item.login?' <span class="text-danger">(Вы)</span>':'')+'</td><td class="td">'+(item.super?'Супер администаторы':(item.support?'Техническая поддержка':'Администраторы'))+'</td>'+(onlySupers?'':'<td class="td">'+(item.added?item.added.login+(Profile&&Profile.login==item.added.login?' <span class="text-danger">(Вы)</span>':''):'')+'</td><td class="td nowrap">'+(item.has_control?(item.support?'<div admin-id="'+item.id+'" class="btn btn-primary admin-change" title="Перенести в группу администраторов"><i class="far fa-user-tag"></i> В администраторы</div>':'<div admin-id="'+item.id+'" class="btn btn-primary admin-change" title="Перенести в группу технической поддержки"><i class="far fa-user-shield"></i> В поддержку</div>')+'<div admin-id="'+item.id+'" class="btn btn-danger admin-remove" title="Удалить администратора"><i class="far fa-times"></i> Удалить</div>':'')+'</td>')+'</tr>';
	},
	user: function(item){
		return '<tr user-id="'+item.id+'"><td class="td">'+item.id+'</td><td>'+item.phone+'</td><td class="td">'+item.balance+'</td><td class="td"'+(item.rent?'title="'+item.rent.start_location+'"':'')+'>'+(item.rent?'<i class="far fa-map-marker cli"></i> '+(item.rent.start_location)+' | <i class="far fa-clock cli"></i> '+timepassed(item.rent.created):'')+'</td></tr>';
	},
	replenishment: function(item, check){
		return '<tr><td class="td">'+item.id+'</td><td class="td">'+timepassed(item.created)+'</td><td class="td">'+item.user.phone+'</td>'+(check?'<td class="td">'+item.value+'</td><td class="td">'+(item.status==0?'Создан':(item.status==1?'Отказ':'Успешно'))+'</td>':'')+'</tr>';
	},
	transport: function(item){
		return '<tr><td class="td">'+item.id+'</td><td class="td">'+timepassed(item.created)+'</td><td class="td">'+item.sid+'</td><td></td></tr>';
	}
};
var RendersEvents = {
	admin: function(view, sort, all){
		all = all === true ? true : false;
		var elements = $('[admin-id]').not('[events]');
		elements.find('.admin-remove').click(function(){
			var adminId = $(this).attr('admin-id');
			var tr = $('tr[admin-id="'+adminId+'"]');
			var adminLogin = $(tr.children()[1]).text();
			api('admin.remove', {id: adminId}, function(res){
				suc("Администратор "+adminLogin+" успешно удалён");
				tr.remove();
			}, function(res){
				var msg = 'Неизвестная ошибка';
				switch(res.code){
					case 0:
						msg = 'Недостаточно прав';
					break;
					case 1:
						msg = 'Администратор не найден';
					break;
				}
			});
		});
		elements.find('.admin-change').click(function(){
			var self = $(this);
			var adminId = self.attr('admin-id');
			var tr = $('tr[admin-id="'+adminId+'"]');
			var adminLogin = $(tr.children()[1]).text();
			var pos = self.text()==' В администраторы' ? false : true;
			var tr = $('tr[admin-id="'+adminId+'"]');
			api('admin.type', {id: adminId, type: pos}, function(res){
				suc(adminLogin+' перенесён в группу '+(!pos?'администраторов':'технической поддержки'));
				if(all){
					if(pos){
						self.attr('title', 'Перенести в группу администраторов').html('<i class="far fa-user-tag"></i> В администраторы');
					}else{
						self.attr('title', 'Перенести в группу технической поддержки').html('<i class="far fa-user-tag"></i> В поддержку');
					}
				}else{
					var ptr = tr.parent();
					if(ptr.children().length==2){
						ptr.append('<tr><td colspan="5" class="text-center">Нет администраторов</td></tr>')
					}
					tr.remove();
				}
			}, function(res){
				err("Не удалось поменять группу администратора");
			});
		});
		var tb = $('tbody', view);
		$('.more', view).not('[events]').attr('events','').click(function(){
			var self = $(this);
			var td = self.parent().parent();
			var offset = td.prev().attr('admin-id');
			self.loader('Подождите...');
			api("admin.get", {offset: offset, sort: sort}, function(res){
				self.html('Показать ещё');
				for(var i = 0; i < res.items.length; i++){
					td.before(Renders.admin(res.items[i]));
				}
				if(!res.items.length||tb.children().length+res.items.length>=res.count){
					td.remove();
				}
			}, function(res){
				self.html('Показать ещё');
			}).fail(function(){
				self.html('Показать ещё');
			});
		});
	},
	history: function(view, sort){
		var tb = $('tbody', view);
		$('.more', view).not('[events]').attr('events','').click(function(){
			var self = $(this);
			var td = self.parent().parent();
			var offset = td.prev().attr('item-id');
			self.loader('Подождите...');
			api("admin.history.get", {offset: offset, sort: sort}, function(res){
				self.html('Показать ещё');
				for(var i = 0; i < res.items.length; i++){
					td.before(Renders.history(res.items[i]));
				}
				if(!res.items.length||tb.children().length+res.items.length>=res.count){
					td.remove();
				}
			}, function(res){
				self.html('Показать ещё');
			}).fail(function(){
				self.html('Показать ещё');
			});
		});
	},
	user: function(view, sort){
		var tb = $('tbody', view);
		$('.more', view).not('[events]').attr('events','').click(function(){
			var self = $(this);
			var td = self.parent().parent();
			var offset = td.prev().attr('user-id');
			self.loader('Подождите...');
			api("admin.users.get", {offset: offset, sort: sort}, function(res){
				self.html('Показать ещё');
				for(var i = 0; i < res.items.length; i++){
					td.before(Renders.user(res.items[i]));
				}
				if(!res.items.length||tb.children().length+res.items.length>=res.count){
					td.remove();
				}
			}, function(res){
				self.html('Показать ещё');
			}).fail(function(){
				self.html('Показать ещё');
			});
		});
	},
	replenishment: function(view, sort, check){
		var tb = $('tbody', view);
		$('.more', view).not('[events]').attr('events','').click(function(){
			var self = $(this);
			var td = self.parent().parent();
			var offset = td.prev().attr('user-id');
			self.loader('Подождите...');
			api("admin.replenishment.get", {offset: offset, sort: sort}, function(res){
				self.html('Показать ещё');
				for(var i = 0; i < res.items.length; i++){
					td.before(Renders.replenishment(res.items[i], check));
				}
				if(!res.items.length||tb.children().length+res.items.length>=res.count){
					td.remove();
				}
			}, function(res){
				self.html('Показать ещё');
			}).fail(function(){
				self.html('Показать ещё');
			});
		});
	}
};
var Pages = {
	main: function(info){
		var viewer = $("#page-content .viewer", this);
		function getHistory()
		{
			function renderHistories(res, render)
			{
				var html = '<div class="table table-responsive"><table><tbody>';
				if(!res.items.length){
					html += '<tr><td class="text-center">Нет данных</td></tr>'
				}
				var count = 0;
				for(var i=0; i<res.items.length; i++){
					if(typeof(render)=="function"){
						html += render.call(this, res.items[i]);
						count++;
					}
				}
				if(count<res.count){
					html += '<tr><td class="text-center"><div class="more btn btn-primary">Показать ещё</div></td></tr>';
				}
				html += '</tbody></table></div>';
				return html;
			};
			viewer.html(`
				<div class="section">
					<div class="section-title">История действий</div>
					<div class="section-content">
						<div id="history-tabs" class="tabs">
							<div class="tabs-list">
								<div class="tab">Все</div>
								<div class="tab">Администраторы</div>
								<div class="tab">Пользователи</div>
								<div class="tab">Пополнения</div>
								<div class="tab">Аренды ТС</div>
							</div>
							<div class="tabs-view">
								<div class="tab"></div>
								<div class="tab"></div>
								<div class="tab"></div>
								<div class="tab"></div>
								<div class="tab"></div>
							</div>
						</div>
					</div>
				</div>`
			);
			function apiAdminHistoreGet(sort, callback)
			{
				sort === undefined ? 0 : sort;
				api('admin.history.get', {sort: sort}, function(res){
					if(typeof(callback)=="function"){
						callback.call(null, res);
					}
				}, function(res){
					err("Не удалось получить историю действий");
				}, function(){
					viewer.loader();
				});
			}
			$("#history-tabs").tabs([
				function(view){
					apiAdminHistoreGet(0,function(res){
						view.html(renderHistories(res, Renders.history));
						RendersEvents.history(view, 0);
					});
				}, function(view){
					apiAdminHistoreGet(1,function(res){
						view.html(renderHistories(res, Renders.history));
						RendersEvents.history(view, 1);
					});
				}, function(view){
					apiAdminHistoreGet(2,function(res){
						view.html(renderHistories(res, Renders.history));
						RendersEvents.history(view, 2);
					});
				}, function(view){
					apiAdminHistoreGet(3,function(res){
						view.html(renderHistories(res, Renders.history));
						RendersEvents.history(view, 3);
					});
				}, function(view){
					apiAdminHistoreGet(4,function(res){
						view.html(renderHistories(res, Renders.history));
						RendersEvents.history(view, 4);
					});
				}
			]);
		};
		function getUsers()
		{
			function renderUsers(res, render)
			{
				var html = '<div class="table table-responsive"><table><tbody><tr class="th"><td>ID</td><td>Номер телефона</td><td>Баланс</td><td>Аренда ТС</td></tr>';
				if(!res.items.length){
					html += '<tr><td class="text-center" colspan="4">Нет данных</td></tr>'
				}
				var count = 0;
				for(var i=0; i<res.items.length; i++) {
					if(typeof(render) == "function"){
						html += render.call(this, res.items[i]);
						count++;
					}
				}
				if(count<res.count){
					html += '<tr><td colspan="4" class="text-center"><div class="more btn btn-primary">Показать ещё</div></td></tr>';
				}
				html += '</tbody></table></div>';
				return html;
			};
			function apiAdminUsersGet(sort, callback)
			{
				sort = sort === undefined ? 0 : sort;
				api( 'admin.users.get', {sort: sort}, function(res){
					if(typeof(callback)=="function"){
						callback.call(null, res);
					}
				}, function(res){
					err("Не удалось получить список пользователей");
				}, function(){
					viewer.loader();
				});
			};
			viewer.html(`
				<div class="section">
					<div class="section-title">Пользователи</div>
					<div class="section-content">
						<div id="users-tabs" class="tabs">
							<div class="tabs-list">
								<div class="tab">Все</div>
								<div class="tab">Активная аренда</div>
							</div>
							<div class="tabs-view">
								<div class="tab"></div>
								<div class="tab"></div>
							</div>
						</div>
					</div>
				</div>
			`);
			$("#users-tabs").tabs([
				function(view){
					apiAdminUsersGet(0, function(res){
						view.html(renderUsers(res, Renders.user));
						RendersEvents.user(view, 0);
					});
				}, function(view){
					apiAdminUsersGet(1, function(res){
						view.html(renderUsers(res, Renders.user));
						RendersEvents.user(view, 1);
					});
				}
			]);
		};
		function getAdmins()
		{
			function renderAdmins(res, render, onlySupers)
			{
				onlySupers = onlySupers === true ? true : false;
				var html = '<div class="table table-responsive"><table><tbody><tr class="th"><td>ID</td><td>Логин</td><td>Группа</td>'+(onlySupers?'':'<td>Добавил</td><td>Действие</td>')+'</tr>';
				var count = 0;
				if(!res.items.length){
					html += '<tr><td colspan="'+(onlySupers?3:5)+'" class="text-center">Нет администраторов</td></tr>';
				}
				for(var i=0; i<res.items.length; i++){
					if(typeof(render)=="function"){
						html += render.call(this, res.items[i], onlySupers);
						count++;
					}
				}
				if(count<res.count){
					html += '<tr><td colspan="'+(onlySupers?3:5)+'" class="text-center"><div class="more btn btn-primary">Показать ещё</div></td></tr>';
				}
				html += '</tbody></table></div>';
				return html;
			};
			function apiAdminGet(sort, callback)
			{
				sort = sort === undefined ? 0 : sort;
				api('admin.get', {sort: sort},function(res){
					if(typeof(callback)=="function") {
						callback.call(null, res);
					}
				}, function(res){
					var msg = 'Неизвестная ошибка';
					switch(res.type){
						case 'METHOD':
							switch(res.code){
								case 0:
									msg = 'Недостаточно прав';
									break;
							}
							break;
					}
					err(msg);
				}, function(){
					viewer.loader();
				});
			};
			viewer.html(`
				<div class="section">
					<div class="section-title">Список администраторов</div>
					<div class="section-content">
						<div id="admin-add-btn" class="btn btn-primary xfull">Добавить администратора</div>
						<div id="admin-tabs" class="tabs">
							<div class="tabs-list">
								<div class="tab">Все</div>
								<div class="tab">Супер администраторы</div>
								<div class="tab">Администраторы</div>
								<div class="tab">Техническая поддержка</div>
								<div class="tab">Управление</div>
							</div>
							<div class="tabs-view">
								<div class="tab"></div>
								<div class="tab"></div>
								<div class="tab"></div>
								<div class="tab"></div>
								<div class="tab"></div>
							</div>
						</div>
					</div>
				</div>`
			);
			$('#admin-add-btn').click(function(){
				modal(`
					<div class="container">
						<div class="row">
							<div class="col-12 col-lg-4 offset-lg-4">
								<div class="section form">
									<div class="section-title">Регистрация администратора</div>
									<div class="section-content">
										<div class="form-group">
											<label>Логин</label>
											<input id="admin-add-login" class="form-control">
										</div>
										<div class="form-group">
											<label>Пароль</label>
											<input id="admin-add-password" type="password" class="form-control">
										</div>
										<div id="admin-add-err" class="full"></div>
										<div class="form-group">
											<div id="btn-admin-add" class="btn btn-primary full">Зарегистрировать администратора</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				`, function(modalHide){
					$("#btn-admin-add").click(function(){
						var login = $("#admin-add-login").val();
						if(!login.length){
							return $("#admin-add-err").err('Придумайте логин администратора');
						}
						var password = $("#admin-add-password").val();
						if(!password.length){
							return $("#admin-add-err").err('Придумайте пароль администратора');
						}
						api('admin.add', {login: login, password: password}, function(res){
							suc("Администратор успешно зарегистрирован");
							modalHide();
							getAdmins();
						}, function(res){
							var msg = 'Неизвестная ошибка';
							switch(res.type){
								case 'METHOD':
									switch(res.code){
										case 0:
											msg = 'Недостаточно прав';
											break;
										case 1:
											msg = 'Данный логин занят';
											break;
									}
									break;
								case 'TYPE':
									msg = 'Некорректный ' + (res.param.name=='login'?'логин':'пароль');
									break;
							}
							$("#admin-add-err").err(msg);
						});
					});
				});
			});
			$("#admin-tabs").tabs([
				function(view){
					apiAdminGet(0, function(res){
						view.html(renderAdmins(res, Renders.admin));
						RendersEvents.admin(view, 0, true);
					});
				}, function(view){
					apiAdminGet(1, function(res){
						view.html(renderAdmins(res, Renders.admin, true));
						RendersEvents.admin(view, 1);
					} );
				}, function(view){
					apiAdminGet(2, function(res) {
						view.html(renderAdmins(res, Renders.admin));
						RendersEvents.admin(view, 2);
					} );
				}, function(view){
					apiAdminGet(3, function(res) {
						view.html(renderAdmins(res, Renders.admin));
						RendersEvents.admin(view, 3);
					});
				}, function(view){
					apiAdminGet(4, function(res) {
						view.html(renderAdmins(res, Renders.admin));
						RendersEvents.admin(view, 4);
					});
				}
			]);
		};
		function getTransport()
		{
			viewer.html(`
				<div class="section">
					<div class="section-title">Упраление ТС</div>
					<div class="section-content">
						<div class="table table-responsive">
							<table>
								<tbody id="transports-list">
								</tbody>
							</table>
						</div>
					</div>
				</div>
			`);
			api( 'admin.transport.get', function(res){
				var html = '<tr class="th"><td>ID</td><td>Дата добавления</td><td>Идентификатор</td><td>Статус</td></tr>';
				if(!res.items.length){
					html += '<tr><td class="text-center" colspan="4">Нет транспортных средств</td></tr>';
				}
				for(var i=0; i<res.items.length;i++){
					if(typeof(Renders.transport)=="function"){
						html += Renders.transport.call(null, res.items[i]);
					}
				}
				$("#transports-list").html(html);
			}, function(res){
				err("Не удалось получить список транспортных средств");
			}, function(){
				viewer.loader();
			});
		};
		function getReplenishments()
		{
			viewer.html(`
				<div class="section">
					<div class="section-title">Пополнения</div>
					<div class="section-content">
						<div id="replenishment-tabs" class="tabs">
							<div class="tabs-list">
								<div class="tab">Все</div>
								<div class="tab">Успешно</div>
								<div class="tab">Отказ</div>
								<div class="tab">Созданные</div>
							</div>
							<div class="tabs-view">
								<div class="tab"></div>
								<div class="tab"></div>
								<div class="tab"></div>
								<div class="tab"></div>
							</div>
						</div>
					</div>
				</div>
			`);
			function renderReplenishment(res, check)
			{
				check = check === false ? false : true;
				var html = '<div class="table table-responsive"><table><tbody><tr class="th"><td>ID</td><td>Дата</td><td>Пользователь</td>'+(check?'<td>Сумма</td><td>Статус</td>':'')+'</tr>';
				if (!res.items.length){
					html += '<tr><td class="text-center" colspan="'+(check?'5':'3')+'">Нет пополнений</td></tr>';
				}
				for(var i = 0; i < res.items.length; i++){
					if(typeof (Renders.replenishment) == "function"){
						html += Renders.replenishment.call(null, res.items[i], check);
					}
				}
				html += '</tbody></table></div>';
				return html;
			};
			function adminReplenishmentGet(sort, callback){
				sort = sort === undefined ? 0 : sort;
				api('admin.replenishment.get', {sort: sort}, function(res){
					if(typeof(callback)=="function"){
						callback.call(null, res);
					}
				}, function(res){
					err("Не удалось получить список пополнений");
				}, function(){
					viewer.loader();
				});
			};
			$("#replenishment-tabs").tabs([
				function(view){
					adminReplenishmentGet(0, function(res){
						view.html(renderReplenishment(res));
						RendersEvents.replenishment(view, 0);
					});
				}, function(view){
					adminReplenishmentGet(3, function(res){
						view.html(renderReplenishment(res));
						RendersEvents.replenishment(view, 3);
					});
				}, function(view){
					adminReplenishmentGet(2, function(res){
						view.html(renderReplenishment(res, false));
						RendersEvents.replenishment(view, 2, false);
					});
				}, function(view){
					adminReplenishmentGet(1, function(res){
						view.html(renderReplenishment(res, false));
						RendersEvents.replenishment(view, 1, false);
					});
				},
			]);
		};
		function getRents()
		{
			viewer.html('Аренды');
		};
		var subpage = '';
		if(info&&info['subpage']!=undefined){
			subpage = info['subpage'];
		}
		var menuItem = $("#page-content .menu .item[page='"+subpage+"'], #page-content .menu-small .item[page='"+subpage+"']");
		var menuItems = $("#page-content .menu .item, #page-content .menu-small .item");
		menuItems.removeClass('active');
		if(menuItem.length&&menuItem.css('display')!='none'){
			menuItem.addClass('active');
		}else{
			$(menuItems[0]).addClass('active');
		}
		var xtitle = $(".menu .item[page='"+subpage+"']").attr('title');
		if(xtitle!=undefined){
			title(xtitle);
		}
		switch( subpage ){
			case 'users':
				getUsers();
			break;
			case 'transport':
				getTransport();
			break;
			case 'rents':
				getRents();
			break;
			case 'replenishment':
				getReplenishments();
			break;
			case 'admins':
				getAdmins();
			break;
			case 'history':
			default:
				getHistory();
				menuItems.removeClass('active');
				$("#page-content .menu .item[page='history'], #page-content .menu-small .item[page='history']").addClass('active');
			break;
		}
	},
	signin: function(){
		$("#btn-signin").not('[evented]').attr('evented','').click( function(){
			var self = $(this);
			if( self.attr('disabled')=='disabled'){
				return true;
			}
			self.attr('disabled', 'disabled');
			$.post('/', { login: $('#signin-login').val(), password: $('#signin-password').val() }, function(res){
				if( res['error'] !== undefined ){
					$("#signin-err").err('Неправильный логин или пароль');
				}else{
					Token = res.response;
					data('token', Token);
					api('admin.profile.get', function(res){
						Profile = res;
						page("main");
						initSite();
					});
				}
				self.removeAttr('disabled');
			}, 'json').fail( function(obj, msg, errno){
				self.removeAttr('disabled');
				err(msg);
			} );
		} );
	}
};
$(document).ready( function(){
	var wnd = $(window);
	wnd.resize(function(){
		data("scroll", wnd.scrollTop());
	});
	wnd.scroll(function(){
		data("scroll", wnd.scrollTop());
	});
	$("#btn-menu").click( function(){
		$(this).removeClass('d-block').addClass('d-none');
		$("#menu .list").removeClass('d-none').addClass('d-block');
	} );
	$(document).click( function(e){
		var self = $(e.target);
		var tmp = self.attr('href');
		if( tmp !== undefined && self.hasClass('link') ){
			e.stopPropagation();
			var xtmp = parseUrl(tmp);
			if(xtmp!=false){
				page(xtmp.page, xtmp.info);
				return true;
			}
			window.open(tmp);
			return true;
		}
		if( !$(e.target).closest('#menu .list, #btn-menu').length){
			$("#btn-menu").removeClass('d-none').addClass('d-block');
			$("#menu .list").removeClass('d-block').addClass('d-none');
		}
	} );
	var menuItem = $("#page-content .menu .item, #page-content .menu-small .item");
	menuItem.click( function(){
		var self = $(this);
		var tmp = $(this).attr('page');
		if(tmp!=undefined){
			menuItem.removeClass('active');
			self.addClass('active');
			page(tmp, {}, false);
		}
	} );
	var pgHeader = $("#page-header");
	var headerLS = $("#page-header .logo-small");
	var headerL = $("#page-header .logo");
	var navigation = $("#page-header .navigation");
	var pgContent = $("#page-content");
	var pgMenuS = $("#page-content .menu-small");
	var pgMenu = $("#page-content .menu");
	var pgViewer = $("#page-content .viewer");
	wnd.resize(function(){
		var currentPage = cpg();
		if(currentPage){
			if(currentPage.attr('page')=="main"){
				$("#page-content .menu, #page-content .menu-small").css({minHeight: (wnd.height()-50)+'px'});
			}
		}
		if(window.matchMedia('(max-width: 768px)').matches){
			navigation.css({marginLeft: '0px'});
			headerLS.hide();
			headerL.show();
			pgViewer.css({marginLeft: '0px'});
			pgMenu.hide();
			pgMenuS.hide();
		}else if( pgHeader.attr('small') == "true" ){
			headerL.hide();
			headerLS.show();
			pgMenu.hide();
			pgMenuS.show();
			pgViewer.css({marginLeft: '50px'});
		}else{
			navigation.css({marginLeft: '0px'});
			headerL.show();
			pgViewer.css({marginLeft: '230px'});
			pgMenu.show();
		}
	});
	wnd.resize();
	$('#btn-navigation').not('[evented]').attr('evented','').click(function(){
		if(!window.matchMedia('(max-width: 768px)').matches){
			if(headerL.css('display') == "none"){
				headerLS.hide();
				headerL.show();
				navigation.css('marginLeft', '230px');
				pgMenuS.hide();
				pgMenu.show();
				pgViewer.css('marginLeft', '230px');
				pgHeader.attr('small', false);
			}else{
				headerL.hide();
				headerLS.show();
				navigation.css('marginLeft', '50px');
				pgMenu.hide();
				pgMenuS.show();
				pgViewer.css('marginLeft', '50px');
				pgHeader.attr('small', true);
			}
		}else{
			pgMenuS.hide();
			if(pgMenu.css('display')=="none"){
				pgViewer.css({marginLeft: "230px"});
				pgMenu.show();
			}else{
				pgViewer.css({marginLeft: "0px"});
				pgMenu.hide();
			}
		}
	});
	$(".btn-signout").click( function(){
		var self = $(this);
		if( self.attr('disabled')=='disabled'){
			return true;
		}
		self.attr('disabled', 'disabled');
		api("signout", function(res){
			self.removeAttr('disabled');
			data('token','');
			Profile = false;
			Token = false;
			initSite();
		}, function(res){
			self.removeAttr('disabled');
			initSite();
		});
	} );
	initSite();
} );
function initSite()
{
	var pageData = parseUrl();
	if(!pageData){
		pageData = { page: 'main', info: {} };
	}
	if(typeof(Token)=='string'&&Token.length==32){
		api('admin.profile.get', function(res){
			Profile = res;
			auth(true);
			$("#admin-login").text(Profile.login).attr('title', Profile.login);
			$("#admin-login-small").text(Profile.login.substring(0,2).toUpperCase()).attr('title', Profile.login);
			$("#preload").hide();
			$("#content").show();
			page(pageData.page, pageData.info);
		}, function(res){
			page(pageData.page, pageData.info);
			$("#preload").hide();
			$("#content").show();
		});
		return true;
	}else{
		page('signin');
	}
	auth(false);
	$("#preload").hide();
	$("#content").show();
};
function modal(html, callback)
{
	var m = $('.xmodal-container');
	if(!m.length){
		$('body').append('<div class="xmodal-container"><div class="xmodal-middle"><div class="xmodal-content"></div></div></div>');
		m = $('.xmodal-container');
		m.click(function(e){
			if(!$(e.target).closest('.xmodal-content').length){
				m.fadeOut();
			}
		});
	}
	$('.xmodal-content').html(html);
	m.fadeIn();
	if(typeof(callback)=="function"){
		callback.call(null, function(){
			m.fadeOut();
		});
	}
};
function scroll()
{
	$(window).scrollTop(data("scroll"));
};
function suc(msg)
{
	$("#global-error-text").suc(msg);
};
function err(msg)
{
	var types = {
		error: "Неизвестная ошибка",
		timeout: "Сервер не отвечает",
		notmodified: "Не изменились данные",
		parsererror: "Ошибка данных",
		abort: "Разрыв соединения"
	};
	if(types[msg] !== undefined){
		msg = types[msg];
	}
	$("#global-error-text").err(msg);
};
function lock(status)
{
	var msg = status;
	status = status === true ? true : false;
	if(status){
		if(typeof(msg)=="string"){
			$("#lock-text").html(msg);
		}
		$("#pages").hide();
		$("#lock").show();
	}else{
		$("#lock").hide();
		$("#pages").show();
	}
};
function auth(status)
{
	status = status == 1 || status == true ? true : false;
	if(status == false){
		Profile = false;
	}
	var isAdmin = Profile && Profile.admin ? true : false;
	var isSupport = Profile && Profile.admin && Profile.support ? true : false;
	$("#auth-styles").html( '.if-ns{ visibility: '+ (!isSupport?'visible':'hidden') +'; '+ (isSupport?'display: none!important;':'') +' } .if-s{ visibility: '+ (isSupport?'visible':'hidden') +'; '+ (!isSupport?'display: none!important;':'') +' } .if-na{ visibility: '+ (!status?'visible':'hidden') +'; '+ (status?'display: none!important;':'') +' } .if-a{ visibility: '+ (status?'visible':'hidden') +'; '+ (!status?'display: none!important;':'') +' } .if-admin{ visibility: '+ (status && isAdmin?'visible':'hidden') +'; '+ (status && isAdmin ?'':'display: none!important;') +' }'  );
};
function data(key, value)
{
	if(value===undefined){
		return localStorage.getItem(key);
	}
	localStorage.setItem(key, value);
};
function time()
{
	return new Date().getTime();
};
function timestamp()
{
	return Math.round( time() / 1000 );
};
function ending( val, fn )
{
	var arr = Array.isArray( fn ) ? fn : [];
	fn = typeof( fn ) == 'function' ? fn : function( val ){
		var value = parseInt( val );
		if( !isNaN( value ) && value == val ){
			if( value > 10 && value < 20 )
				return arr[2] !== undefined ? arr[2] : '';
			if( value % 10 === 1 )
				return arr[0] !== undefined ? arr[0] : '';
			else if( value % 10 > 1 && value % 10 <= 4 )
				return arr[1] !== undefined ? arr[1] : '';
			else
				return arr[2] !== undefined ? arr[2] : '';
		}
		return val;
	};
	return fn.call( this, val );
};
function date( format, tm )
{
	tm = tm === undefined ? timestamp() : tm;
	var date = new Date( tm * 1000 );
	var Y = date.getFullYear().toString();
	var y = Y.substring(2);
	var d = ("0"+date.getDate()).slice(-2);
	var m = ("0"+(date.getMonth()+1)).slice(-2);
	var H = ("0"+date.getHours()).slice(-2);
	var h = ("0"+(date.getHours()>11?date.getHours()-12:date.getHours())).slice(-2);
	var i = ("0"+date.getMinutes()).slice(-2);
	var s = ("0"+date.getSeconds()).slice(-2);
	return format.replace('d',d).replace('m',m).replace('y',y).replace('Y',Y).replace('H',H).replace('h',h).replace('i',i).replace('s',s);
};
function endingPref( val, arr, pref, addVal )
{
	arr = Array.isArray( arr ) ? arr : [];
	if( typeof( pref ) == 'boolean' ){
		addVal = pref;
		pref = '';
	}
	addVal = typeof( addVal ) == 'boolean' ? addVal : true;
	pref = typeof( pref ) == 'string' ? pref : '';
	return (addVal&&val!=1?val+' ':'') + pref + (pref!=''?' ':'') + ending( val, arr );
};
function endingDays( val, pref, addVal )
{
	return endingPref( val, [ 'день', 'дня', 'дней' ], pref, addVal )
};
function endingHours( val, pref, addVal )
{
	return endingPref( val, [ 'час', 'часа', 'часов' ], pref, addVal );
};
function endingMinutes( val, pref, addVal )
{
	return endingPref( val, [ 'минуту', 'минуты', 'минут' ], pref, addVal );
};
function endingTime( val )
{
	return ending( val, function(){
		var tm = parseInt( val );
		if( !isNaN( tm ) && tm == val ){
			var days = Math.floor( tm / 86400 );
			var tm = tm - days * 86400;
			if( days > 0 )
				return endingDays( days );
			else{
				var h = Math.floor( tm / 3600 );
				tm = tm - h * 3600;
				if( h > 0 ){
					return endingHours( h );
				}else{
					var m = Math.floor( tm / 60 );
					if( m > 0 ){
						return endingMinutes( m );
					}else
						return val;
				}
			}
		}
		return val;
	} );
};
var timepassedTimer = setInterval(function(){
	var timepasseds = $(".timepassed");
	timepasseds.each(function(i, e){
		var obj = $(e);
		obj.replaceWith(timepassed(parseInt(obj.attr('value')), obj.attr('status')=='true'?true:false));
	});
}, 1000);
function timepassed( val, status )
{
	status = status === true ? true : false;
	var tm = timestamp() - val;
	if( tm < 0 )
		tm = Math.abs( tm );
	if( tm >= 864000 )
		return date( 'd.m.Y', val );
	var result = endingTime( tm );
	return '<span class="timepassed" value="'+val+'" status="'+status+'">'+(result == tm ? (status?'онлайн':'только что') : result + ' назад')+'</span>';
};
function parserUrl( url )
{
	var a = $('<a>', { href : url } );
	var obj = {};
	var keys = [ 'href', 'host', 'hostname', 'pathname', 'search', 'protocol', 'hash' ];
	for( var i = 0; i < keys.length; i++ )
		obj[keys[i]] = a.prop(keys[i]);
	return obj == {} ? false : obj;
};
function replaceAll(a, b, c)
{
	if( typeof(b) == "object" ){
		for( var p in b )
			a = replaceAll(a,p,b[p]);
		return a;
	}else
		return a.split(b).join(c);
};
function send(url, params, callback, error, options, needloader)
{
	var tm = (new Date).getTime();
	if(typeof(params) == 'function'){
		options = error;
		error = callback;
		callback = params;
		params = {};
	}
	options = typeof(options) == "object" ? options : {};
	options.url = url;
	options.data = params;
	options.success = function(a){
		var dtm = (new Date).getTime() - tm;
		if(query){
			clearInterval(query);
		}
		return callback.call(this, a);
	};
	options.error = function(a, b, c){
		if(query){
			clearInterval(query);
		}
		return error.call(this, a, b, c);
	};
	if(options['dataType'] === undefined){
		options.dataType = 'json';
	}
	var query = setInterval(function(){
		var xtm = (new Date).getTime() - tm;
		if(xtm>1000 && typeof(needloader)=='function'){
			clearInterval(query);
			needloader.call(this);
		}
	}, 50);
	var ajax = $.ajax(options);
	ajax.fail(function(){
		if(query){
			clearInterval(query);
		}
	});
	return ajax;
};
function api(method, params, callback, error, needloader)
{
	if(typeof(params) == "function"){
		needloader = error;
		error = callback;
		callback = params;
		params = {};
	}else if(params === undefined)
		params = {};
	params.method = method;
	if(typeof(Token) == "string" && Token.length == 32){
		params['token'] = Token;
	}
	var ajax = send( ApiHost, params, function(res){
		if(res['error']!=undefined){
			if( res.error.type == 'PARAM' && res.error.code == 1 && res.error.name == 'token' ){
				data('token', '');
				page();
			}
		}
		if(res.error && typeof(error) == 'function'){
			error.call(this, res.error);
		}
		if(res.response != undefined && typeof(callback) == 'function'){
			callback.call(this, res.response);
		}
	}, function(obj, msg, errno){
		err(msg);
	}, { method: 'GET', context: this }, needloader);
	return ajax;
};
function rand(min, max)
{
	return max ? Math.floor( Math.random() * ( max - min + 1 ) ) + min : Math.floor( Math.random() * ( min + 1 ) );
};
function title(title)
{
	title = typeof( title ) == 'string' ? title : '';
	document.title = title = ( Title != undefined ? Title + ' | ' : '' ) + title; 
	history.replaceState( null, title, location.href );
};
function pg(page)
{
	var tmp = $("#pages .page[page='"+page+"']");
	if(!tmp.length){
		return false;
	}
	return tmp;
};
function cpg()
{
	var tmp = $("#pages .page:visible");
	if(tmp.length){
		return tmp;
	}
	return false;
};
function pageLoader(status, fn, animate)
{
	var pgLoader = $("#page-loader");
	if(pgLoader.attr('block') == 'true')
		return false;
	pgLoader.attr('block', 'true');
	if(typeof(status) == "function"){
		animate = fn;
		fn = status;
		status = false;
	}
	if(typeof(fn)=='boolean'){
		animate = fn;
	}
	animate = animate === false ? false : true;
	if(status == true){
		pgLoader.hide();
	}
	if(!animate){
		if(status!=true){
			pgLoader.show();
		}
		pgLoader.attr('block', 'false');
		if(typeof(fn) == "function"){
			fn.call(this);
		}
		return true;
	}
	$("#pages").animate({ opacity: status == true ? 1 : 0 }, {
		duration: 500,
		done: function(){
			if(status != true){
				pgLoader.show();
			}
			pgLoader.attr('block', 'false');
			if(typeof(fn) == "function"){
				fn.call(this);
			}
		}
	});
};
function parseUrl(url, info)
{
	if(url===undefined){
		url = location.href;
	}
	info = typeof(info) == 'object' ? info : {};
	var a = $('<a>', { href : url });
	if(a.prop('host') != location.host){
		return true;
	}
	url = a.prop('pathname');
	var arr = url.split( '/' );
	var narr = [];
	for( var i = 0; i < arr.length; i++ ){
		if( arr[i] != "" ){
			narr.push( arr[i] );
		}
	}
	arr = narr;
	if(!arr.length){
		arr.push('main');
	}
	var pageObj = pg(arr[0]);
	if(pageObj===false){
		arr = ['main'].concat(arr);
	}
	if(arr.length > 1){
		var value = parseInt( arr[1] );
		if(value.toString() == arr[1])
			info['id'] = value;
		else{
			info['subpage'] = arr[1];
			var xarr = arr.slice();
			xarr.shift();
			xarr.shift();
			info['data'] = xarr;
		}
	}
	return {
		page: arr[0],
		info: info
	};
};
function page(page, info, animate)
{
	animate = animate !== true ? false : true;
	if(page==undefined)
		page = location.href;
	var pageData = parseUrl(page, info);
	if(pageData!=false){
		page = pageData.page;
		info = pageData.info;
	}
	var url = [];
	if(page !== 'main'){
		url.push(page);
	}
	var nopushstate = false;
	if(typeof(info) == 'object'){
		if(info['id'] != undefined){
			url.push(info['id']);
		}else if(info['subpage'] != undefined){
			url.push(info['subpage']);
			if(typeof(info['data']) == 'object' && info.data.hasOwnProperty('length')){
				for( var i = 0; i < info.data.length; i++ ){
					url.push(info.data[i]);
				}
			}
		}
		if(info['nopushstate'] === true){
			nopushstate = true;
		}
	}
	url = url.join("/");
	var xurl = parserUrl('/'+url);
	if(!xurl){
		page = 'main';
		url = '/';
		info: {};
	}else{
		url = xurl['href'];
	}
	if(!nopushstate){
		if(location.href != url){
			history.pushState(null, typeof(info) == 'object' && info['title'] != undefined ? info['title'] : null, url);
		}else{
			history.replaceState(null, typeof(info) == 'object' && info['title'] != undefined ? info['title'] : null, url);
		}
	}
	var type = typeof(Profile) != 'object' ? 0 : Profile['admin'] == 1 ? 1 : 2;
	var pageObj = pg(page);
	var pages = $("#pages");
	var lock = $("#lock");
	if( ( pageObj.hasClass('if-admin') && type != 1 ) || ( pageObj.hasClass( 'if-a' ) && type == 0 ) || ( pageObj.hasClass( 'if-na' ) && type != 0 ) ){
		pages.hide();
		$("#lock-text").html('<i class="far fa-lock"></i> '+(pageObj.hasClass('if-admin') && type != 1?'Нет прав для просмотра данной страницы':'Страница недоступна'));
		title( $("#lock-text").text() );
		lock.show();
	}else{
		lock.hide();
		pages.show();
		var xtitle = pageObj.attr('')
		pageLoader(function(){
			$("#pages .page").addClass('d-none');
			pageObj.removeClass('d-none');
			info = typeof(info) == 'object' ? info : {};
			if(Pages.hasOwnProperty(page) && typeof(Pages[page]) == "function"){
				var result = Pages[page].call( pageObj, info );
				$(window).resize();//fix
				if(result == true){
					return true;
				}
			}
			pageLoader(true, animate);
		}, animate );
	}
	return true;
};
(function($){
	$.fn.tabs = function( callbacks )
	{
		var obj = this;
		if( !obj.length ){
			return false;
		}
		callbacks = Array.isArray( callbacks ) ? callbacks : [];
		var tabs = $('.tabs-list .tab', obj);
		var list = $('.tabs-view .tab', obj);
		tabs.click( function(){
			var tab = this;
			tabs.each( function(i, e){
				if( tab == e ){
					tabs.removeClass('active');
					$(tab).addClass('active');
					list.hide();
					tab = $(tab);
					var view = $(list[i]);
					$(view).show();
					if( obj.attr('id') !== undefined ){
						data( obj.attr('id'), i );
					}
					if( callbacks[i] !== undefined && typeof( callbacks[i] ) == "function" ){
						callbacks[i].call( obj, view, tab );
					}
				}
			} );
		} );
		if( obj.attr('id') !== undefined ){
			var index = parseInt( data( obj.attr('id') ) );
			if( !isNaN(index) ){
				$(tabs[index]).click();
			}
		}
	};
	$.fn.tmonchange = function(callback, time)
	{
		var self = this;
		if(!self.length){
			return false;
		}
		time = isNaN(parseInt(time))?3000:parseInt(time);
		time = time < 0 ? 0 : time;
		var tm = false;
		var beforeValue = self.val();
		var checktype = function()
		{
			var type = self.attr('t');
			var value = self.val();
			switch( type ){
				case 'int':
					self.val(isNaN(parseInt(value))?0:parseInt(value));
				break;
				case 'float':
					self.val(isNaN(parseFloat(value))?0:parseFloat(value));
				break;
				case 'percent':
					value = isNaN(parseInt(value))?0:parseInt(value);
					if(value<0){
						value = 0;
					}
					if(value>100){
						value = 100;
					}
					self.val(value);
				break;
				case 'count':
					value = isNaN(parseInt(value))?0:parseInt(value);
					if(value<1){
						value = 1;
					}
					self.val(value);
				break;
			}
		};
		var handle = function()
		{
			if(tm){
				clearTimeout(tm);
			}
			var value = self.val();
			if(before!=value&&typeof(callback)=="function"){
				checktype();
				callback.call(self, value);
			}
		};
		self.off('keyup paste focus blur').on('focus', function(){
			before = self.val();
		}).on('keyup paste', function(){
			var value = self.val();
			if(tm){
				clearTimeout(tm);
			}
			if( before != value ){
				tm = setTimeout( function(){
					handle();
				}, time );
			}
		}).on('blur', function(){
			handle();
		});
	};
	$.fn.loader = function(msg)
	{
		this.html('<span class="loader-fix"><img class="loader" src="/img/loader.gif">' + (typeof(msg)=="string"&&msg.length?msg: '')+'</span>');
	};
	var jqueryAlertTimers = [];
	var jqueryAlertId = 0;
	$.fn.alert = function( msg, time, before, after )
	{	
		var self = this;
		var alertId = self.attr('alert-id');
		if(alertId==undefined){
			alertId = jqueryAlertId++;
			self.attr('alert-id', alertId);
		}else
			alertId = parseInt(alertId);
		time = isNaN(parseInt(time))?0:parseInt(time);
		time = time < 0 ? 0 : time;
		if( !self.hasClass('alert') ){
			self.addClass('alert');
		}
		if( !self.hasClass('alert-info') ){
			self.addClass('alert-info');
		}
		if(typeof(before)=="function"){
			before.call(self);
		}
		if(jqueryAlertTimers[alertId] != undefined ){
			clearTimeout(jqueryAlertTimers[alertId]);
			delete jqueryAlertTimers[alertId];
		}
		self.text(msg).css({display: 'inline-block'});
		if(!time){
			if(typeof(after)=="function"){
				after.call(self);
			}
			return true;
		}
		jqueryAlertTimers[alertId] = setTimeout(function(){
			delete jqueryAlertTimers[alertId];
			if( self.hasClass('alert-info') ){
				self.removeClass('alert-info');
			}
			self.hide();
			if(typeof(after)=="function"){
				after.call(self);
			}
		}, time);
	};
	$.fn.err = function( msg, time )
	{
		this.alert(msg, time === undefined ? 3000: time, function(){
			this.removeClass('alert-info alert-success').addClass('alert-danger');
		}, function(){
			this.remove('alert-danger');
		});
	};
	$.fn.suc = function( msg, time )
	{
		this.alert(msg, time === undefined ? 3000: time, function(){
			this.removeClass('alert-info alert-danger').addClass('alert-success');
		}, function(){
			this.remove('alert-success');
		});
	};
})(jQuery);