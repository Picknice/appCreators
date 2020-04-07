<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->optional([
	'id' => 'id'
]);
return function($id){
    $admin = $this->admin();
    if(!$admin){
        return $this->error(0);
    }
	$user = $this->user($id);
	if(!$user){
		return $this->error(1);
	}
	if(!$user['admin']){
		return $this->error(2);
	}
	$admin = $this->query("SELECT * FROM admins WHERE uid=?", $user['id'])->fetch_assoc();
	$user['super'] = is_array($admin)||$admin===false ? 0 : 1;
	return $this->fields( $user, [], [ 'balance', 'password', 'verify_block', 'verify_block_time', 'verify_code', 'verify_created', 'verify_checked' ], [ 'phone' => 'login' ] );
};