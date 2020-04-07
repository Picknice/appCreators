<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->params([
	'phone' => 'phone',
	'code' => 'int'
]);
$this->methodType = false;
return function($phone, $code, $aid){
	$user = $this->query( "SELECT * FROM users WHERE phone=?", $phone )->fetch_assoc();
	if( !$user ){
		return $this->error(1);
	}
	$time = time();
	if( !$user['verify_checked'] || time() - 180 > $user['verify_created'] ){
	    if( !$user['verify_checked'] ){
	        if( $user['verify_block'] == 3 ){
	            return $this->error(5);
            }
            $this->query( "UPDATE users SET verify_block = verify_block + 1, verify_checked=3, verify_block_time=? WHERE id=?", $time, $user['id'] );
	        return $this->error(6);
        }
	    if( $time - $user['verify_block_time'] < 300 ){
	        return $this->error(6);
        }
		$this->sendVerifyCode( $user['id'] );
		return $this->error( !$user['verify_checked'] ? 3 : 4 );
	}
	if( $user['verify_code'] != $code ){
		$this->query( "UPDATE users SET verify_checked=verify_checked-1 WHERE id=?", $user['id'] );
		return $this->error(4);
	}
    $ip = isset($_SERVER['HTTP_CLIENT_IP']) ? $_SERVER['HTTP_CLIENT_IP'] : (isset($_SERVER['HTTP_X_FORWARDED_FOR']) ? $_SERVER['HTTP_X_FORWARDED_FOR'] : $_SERVER['REMOTE_ADDR']);
    $token = $this->token();
    $this->query("DELETE FROM app_sessions WHERE uid=?", $user['id'] ); #remove all tokens
    if( $this->query( "INSERT INTO app_sessions (aid,uid,created,token,ip,last_call,call_count,block_time,block_lvl,user_agent) VALUES (?,?,?,?,?,?,?,?,?,?)", $aid, $user['id'], $time, $token, $ip, $time, 0, 0, 0, isset($_SERVER['HTTP_USER_AGENT'])?$_SERVER['HTTP_USER_AGENT']:($aid==1?'app #1':'')) ){
        $this->query( "UPDATE users SET verify_code=? WHERE id=?", '', $user['id'] );
        return $token;
    }
    return false;
};