<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->params([
	'id' => 'id',
	'type' => 'bool'
]);
return function($id, $type){
	$admin = $this->admin();
	if( !$admin ){
		return $this->error(0);
	}
	$adminProfile = $this->query("SELECT users.*, admins.added FROM users INNER JOIN admins ON users.id = admins.uid WHERE users.id=?", $id)->fetch_assoc();
	if($admin['super']||$admin['id']==$adminProfile['added']){
        return $this->query( [
            [ "UPDATE users SET support=? WHERE id=?", (int)$type, $adminProfile['id'] ],
            [ "INSERT INTO history (uid,type,created,text) VALUES (?,?,?,?)", $admin['id'], 0, time(), 'Перенёс '. $adminProfile['phone'] . ' в группу ' . ($type?'технической поддержки':'администраторов') ]
        ] );
    }
	return $this->error(1);
};