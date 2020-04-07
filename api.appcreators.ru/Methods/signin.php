<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->params([
	'phone' => 'phone'
]);
$this->methodType = false;
return function($phone, $aid){
    $time = time();
    $user = $this->query( "SELECT * FROM users WHERE phone=?", $phone )->fetch_assoc();
	if( !$user ){
        $time = time();
        $verifyCode = mt_rand(1000,9999);
        if( !$this->query( "INSERT INTO users (phone,created) VALUES (?,?)", $phone, $time ) || !$this->query( "INSERT INTO history (uid,type,created,text) VALUES (?,?,?,?)", $this->query->db->insert_id, 1, $time, 'Зарегистрировался' ) ){
            return $this->error(1);
        }
		$user = $this->query( "SELECT * FROM users WHERE phone=?", $phone )->fetch_assoc();
	}
	$ip = isset($_SERVER['HTTP_CLIENT_IP']) ? $_SERVER['HTTP_CLIENT_IP'] : (isset($_SERVER['HTTP_X_FORWARDED_FOR']) ? $_SERVER['HTTP_X_FORWARDED_FOR'] : $_SERVER['REMOTE_ADDR']);
    $verifyCode = mt_rand(1000,9999);
    /* send verify code */
    return $this->query( "UPDATE users SET verify_code=?,verify_created=?,verify_checked=? WHERE id=?", $verifyCode, $time, 3, $user['id'] );
};