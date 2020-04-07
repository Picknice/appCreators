<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->params([
	'id' => 'id'
]);
return function($id){
	$admin = $this->admin();
	if( !$admin ){
		return $this->error(0);
	}
	$adminProfile = $this->query("SELECT users.*, admins.added FROM users INNER JOIN admins ON users.id = admins.uid WHERE users.id=?", $id)->fetch_assoc();
    if($admin['super']||$admin['id']==$adminProfile['added']){
        return $this->query( [
            [ "DELETE FROM users WHERE id=?", $adminProfile['id'] ],
            [ "DELETE FROM admins WHERE uid=?", $adminProfile['id'] ],
            [ "INSERT INTO history (uid,type,created,text) VALUES (?,?,?,?)", $admin['id'], 0, time(), 'Удалил администратора ' . $adminProfile['phone'] ]
        ] );
	}
	return $this->error(1);
};