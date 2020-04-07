<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->params([
	'login' => 'login',
	'password' => 'password'
]);
return function($login, $password){
	$admin = $this->admin();
	if(!$admin){
		return $this->error(0);
	}
	$user = $this->query("SELECT * FROM users WHERE phone=?", $login)->fetch_assoc();
	if($user){
		return $this->error(1);
	}
	if(!$this->query("INSERT INTO users (phone,password,created,admin) VALUES (?,?,?,?)", $login, $password, time(), 1 )){
		return $this->error(2);
	}
	if(!$this->query("INSERT INTO admins (added,created,uid) VALUES (?,?,?)", $admin['id'], time(), $this->query->db->insert_id)){
		return $this->error(3);
	}
	return $this->query( "INSERT INTO history (uid,type,created,text) VALUES (?,?,?,?)", $admin['id'], 0, time(), 'Зарегистрировал администратора ' . $login );
};