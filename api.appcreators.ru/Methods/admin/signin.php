<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->params([
	'login' => 'login',
	'password' => 'string'
]);
$this->methodType = false;
return function($login, $password, $aid){
	$user = $this->query( "SELECT * FROM users WHERE phone=?", $login )->fetch_assoc();
	if( !$user ){
		return $this->error(1);
	}
	if( !$user['admin'] ){
		return $this->error(2);
	}
	if( !password_verify( $password, $user['password'] ) ){
		return $this->error(3);
	}
	$ip = isset($_SERVER['HTTP_CLIENT_IP']) ? $_SERVER['HTTP_CLIENT_IP'] : (isset($_SERVER['HTTP_X_FORWARDED_FOR']) ? $_SERVER['HTTP_X_FORWARDED_FOR'] : $_SERVER['REMOTE_ADDR']);
	$token = $this->token();
	$time = time();
	if( $this->query( "INSERT INTO app_sessions (aid,uid,created,token,ip,last_call,call_count,block_time,block_lvl,user_agent) VALUES (?,?,?,?,?,?,?,?,?,?)", $aid, $user['id'], $time, $token, $ip, $time, 0, 0, 0, isset($_SERVER['HTTP_USER_AGENT'])?$_SERVER['HTTP_USER_AGENT']:($aid==1?'app #1':'')) ){
		return $token;
	}
	return false;
};