<?php
define('v', time());
define('grSiteKey', '6LcXod0UAAAAAOT1AxSpub4FJ6eOlJ8goKivPp2I');
define('grSecretKey', '6LcXod0UAAAAACNVHVsiRywpVrvMZ9a567TGwaVh');
if( isset( $_POST['login'] ) && isset( $_POST['password'] ) ){
	header('Access-Control-Allow-Origin: *' );
	header('Content-type: application/json; charset=utf-8' );
	$curl = curl_init('https://api.appcreators.ru?method=admin.signin&aid=1&secret=e37379a73099d51ac9d36a9ca24986c2&login='.$_POST['login'].'&password='.$_POST['password']);
	curl_setopt($curl, CURLOPT_USERAGENT, isset($_SERVER['HTTP_USER_AGENT'])?$_SERVER['HTTP_USER_AGENT']:'');
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	echo curl_exec($curl);
	curl_close($curl);
	die;
}
?>
<!DOCTYPE html>
<html>
	<head>
		<title>Панель управления</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link href="/css/bootstrap.min.css" rel="stylesheet">
		<link href="/css/font-awesome.min.css" rel="stylesheet">
		<link href="/css/main.css?v=<?=v?>" rel="stylesheet">
		<script src="/js/jquery-3.4.1.min.js"></script>
		<script src="/js/bootstrap.min.js"></script>
		<script> v = "<?=v?>"; </script>
	</head>
	<body>
		<div  id="preload">
			<img class="loader" src="/img/loader.gif">
			<b id="preload-text"></b>
		</div>
		<div id="content">
			<div id="page-loader">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<img src="/img/loader.gif">
						</div>
					</div>
				</div>
			</div>
			<div id="pages">
				<div class="page if-admin" page="main">
                    <div id="page-header">
                        <div class="logo-small">ПУ</div>
                        <div class="logo">Панель управления</div>
                        <div class="navigation">
                            <div id="btn-navigation" class="item"><i class="fas fa-bars"></i></div>
                        </div>
                    </div>
                    <div id="page-content">
                        <div class="menu-small">
                            <div id="admin-login-small"></div>
                            <div class="item if-s far fa-life-ring" page="support" title="Техническая поддержка"></div>
                            <div class="item if-ns far fa-user-shield" page="admins" title="Администраторы"></div>
                            <div class="item far fa-users" page="users" title="Пользователи"></div>
                            <div class="item far fa-coins" page="replenishment" title="Пополнения"></div>
                            <div class="item if-ns far fa-exchange" page="transport" title="Управление ТС"></div>
                            <div class="item if-ns far fa-history" page="history" title="История действий"></div>
                            <div class="item text-danger far fa-sign-out btn-signout" title="Выход"></div>
                        </div>
                        <div class="menu">
                            <div id="admin-login"></div>
                            <div class="item if-s" page="support" title="Техническая поддержка"><i class="far fa-life-ring"></i> Техническая поддержка</div>
                            <div class="item if-ns" page="admins" title="Администраторы"><i class="far fa-user-shield"></i> Администраторы</div>
                            <div class="item" page="users" title="Пользователи"><i class="far fa-users"></i> Пользователи</div>
                            <div class="item" page="replenishment" title="Пополнения"><i class="far fa-coins"></i> Пополнения</div>
                            <div class="item if-ns" page="transport" title="Управление ТС"><i class="far fa-exchange"></i> Управление ТС</div>
                            <div class="item if-ns" page="history" title="История действий"><i class="far fa-history"></i> История действий</div>
                            <div class="item text-danger btn-signout" title="Выход"><i class="far fa-sign-out"></i> Выход</div>
                        </div>
                        <div class="viewer"></div>
                    </div>
				</div>
				<div class="page if-na container pt-5" page="signin">
					<div class="col-12 col-lg-4 offset-lg-4 section">
						<div class="section-title">Вход в панель управления</div>
						<div class="section-content form">
							<div class="form-group">
								<label>Логин</label>
								<input id="signin-login" class="form-control">
							</div>
							<div class="form-group">
								<label>Пароль</label>
								<input id="signin-password" class="form-control" type="password">
							</div>
							<div id="signin-err" class="error"></div>
							<div class="form-group">
								<div id="btn-signin" class="btn btn-primary">Войти</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="lock">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div id="lock-text" class="alert alert-danger">Страница не загружена</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="global-error">
			<div class="container">
				<div class="row">
					<div class="col-12 text-center">
						<div id="global-error-text" class="alert alert-danger"></div>
					</div>
				</div>
			</div>
		</div>
		<style id="auth-styles"></style>
		<script src="/js/main.js?v=<?=v?>"></script>
	</body>
</html>