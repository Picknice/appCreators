<?php

declare(strict_types=1);
$configFile = dirname(__DIR__) . '/config.php';
$this->db = null;
$this->methodType = true;
if( !file_exists( $configFile ) ){
    throw new Exception( "Configuration file not found in path '$configFile'" );
}
require_once $configFile;
$this->off = function( array $arr = [], array $off = [] ){
    foreach( $off as $v )
        if( isset( $arr[$v] ) )
            unset( $arr[$v] );
    return $arr;
};
$this->on = function( array $arr = [], array $on = [] ){
    if( !count( $on ) )
        return $arr;
    $res = [];
    foreach( $on as $v )
        if( isset( $arr[$v] ) )
            $res[$v] = $arr[$v];
    return $res;
};
$this->fields = function( array $arr = [], array $on = [], array $off = [], array $change = [], array $empty = [] ){
    $arr = $this->off( $arr, $off );
    $arr = $this->on( $arr, $on );
    foreach( $change as $k => $v ){
    	if( array_key_exists($k, $arr) ){
    		$keys = array_keys($arr);
    		$keys[array_search($k, $keys)] = $v;
    		$arr = array_combine($keys, $arr);
    	}
    }
    foreach( $empty as $v ){
        if( isset( $arr[$v] ) && !$arr[$v] ){
            $arr[$v] = null;
        }
    }
    return $arr;
};
$this->user = function( $id = null )
{
    if( $id === null && $this->session )
        $id = $this->session['uid'];
    $user = $this->query( "SELECT * FROM users WHERE id=?", $id )->fetch_assoc();
    if( $user ){
        return $user;
    }
    return false;
};
$this->admin = function( $id = null )
{
    $user = $this->user( $id );
    if( $user && $user['admin'] ){
        $admin = $this->query("SELECT * FROM admins WHERE uid=?", $user['id'])->fetch_assoc();
        $user['super'] = is_array($admin)||$admin===false ? 0: 1;
        return $user;
    }
    return false;
};
$this->sendVerifyCode = function( $uid )
{
    $user = $this->query( "SELECT * FROM users WHERE id=?", $uid )->fetch_assoc();
    if( !$user ){
        return false;
    }
    $verifyCode = rand(1000, 9999);
    /* send verify code */
    $this->query( "UPDATE users SET verify_checked=3, verify_code=?, verify_created=? WHERE id=?", $verifyCode, time(), $user['id'] );
};
return function( string $method, array $params = [], string $version = '' ){
    $this->appType = 0;
    $this->tokenType = 0;
    $methodClosure = $this->getMethod( $method, $version );
    $noCheck = [];
    if( is_array( $methodClosure ) ){
        return $methodClosure;
    }
    if( $this->methodType ){
        $tokenParams = $this->checkParams( [ 'token' => 'hash' ], $params );
        if( isset( $tokenParams['error'] ) ){
            return $tokenParams;
        }
        $session = $this->query( "SELECT * FROM app_sessions WHERE token=?", $tokenParams['token'] )->fetch_assoc();
        if( !$session ){
            return $this->error( 4, 'SESSION' );
        }
        $lastCall = $session['last_call'];
        $callCount = $session['call_count'];
        $blockTime = $session['block_time'];
        $blockLvl = $session['block_lvl'];
        $date = time();
        if( $blockTime > $date ){
            $blockLvl++;
            $blockLvl = $blockLvl > 20 ? 20 : $blockLvl;
            return $this->error( 5, 'SESSION' );
        }
        if( $lastCall == $date )
            $callCount++;
        else{
            $callCount = 0;
            if( $blockLvl > 0 )
                $blockLvl--;
        }
        if( $callCount >= 15 ){
            $blockLvl = $blockLvl > 20 ? 20 : $blockLvl;
            $blockTime = $date + 10 + ceil( pow( $blockLvl, 2 ) * 0.2 );
            return $this->error( 5, 'SESSION' );
        }
        $lastCall = $date;
        $this->query( "UPDATE users SET last_call=?, call_count=?, block_time=?, block_lvl=? WHERE id=?", $lastCall, $callCount, $blockTime, $blockLvl, $session['id'] );
        if( !$this->rules->check( $session['type'], $this->tokenType ) ){
            return $this->error( 6, 'SESSION' );
        }
        $this->session = $session;
        $user = $this->user();
        if(!$user){
            return $this->error( 7, 'SESSION' );
        }
    }else{
        $appParams = $this->checkParams( [ 'aid' => 'id', 'secret' => 'hash' ], $params );
        if( isset( $appParams['error'] ) ){
            return $appParams;
        }
        $app = $this->query( "SELECT * FROM apps WHERE id=?", $appParams['aid'] )->fetch_assoc();
        if( !$app ){
            return $this->error( 0, 'APP' );
        }
        if( $app['deleted'] ){
            return $this->error( 1, 'APP' );
        }
        if( $app['secret'] != $appParams['secret'] ){
            return $this->error( 2, 'APP' );
        }
        if( !$this->rules->check( $app['type'], $this->appType ) ){
            return $this->error( 3, 'APP' );
        }
        $noCheck['aid'] = $app['id'];
    }
    $response = $this->callMethod( $methodClosure, $params, $noCheck );
    if( isset( $response['error'] ) ){
        return $response;
    }
    return [ 'response' => $response ];
};