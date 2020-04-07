<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->optional([
    'offset' => 'uint',
    'count' => 'uint',
    'sort' => 'uint'
]);
return function($offset, $count, $sort){
    $offset = $offset === null ? 0 : $offset;
    if($offset===null){
        $offset = 0;
    }
    if($count<1){
        $count = 20;
    }
    if($count > 100){
        $count = 100;
    }
    if($sort===null){
        $sort = 0;
    }
	$admin = $this->admin();
	if( !$admin ){
		return $this->error(0);
	}
    switch($sort){
        case 0:
            $countSelect = $this->query("SELECT COUNT(*) as count FROM users LEFT JOIN admins ON users.id=admins.uid WHERE users.admin=1")->fetch_assoc();
            $admins = $this->query("SELECT users.*,admins.added as added FROM users LEFT JOIN admins ON users.id=admins.uid WHERE users.admin=1 AND users.id > $offset ORDER BY id ASC LIMIT $count")->fetch_all( MYSQLI_ASSOC );
        break;
        case 1:
            $countSelect = $this->query("SELECT COUNT(*) as count FROM users LEFT JOIN admins ON users.id=admins.uid WHERE admins.id IS NULL AND users.admin=1 AND users.support=0")->fetch_assoc();
            $admins = $this->query("SELECT users.*, admins.added FROM users LEFT JOIN admins ON users.id=admins.uid WHERE admins.id IS NULL AND users.admin=1 AND users.support=0  AND users.id > $offset ORDER BY id ASC LIMIT $count")->fetch_all( MYSQLI_ASSOC );
        break;
        case 2:
            $countSelect = $this->query("SELECT COUNT(*) as count FROM users INNER JOIN admins ON users.id=admins.uid WHERE users.admin=1 AND users.support=0")->fetch_assoc();
            $admins = $this->query("SELECT users.*,admins.added FROM users INNER JOIN admins ON users.id=admins.uid WHERE users.admin=1 AND users.support=0 AND users.id > $offset ORDER BY id ASC LIMIT $count")->fetch_all( MYSQLI_ASSOC );
        break;
        case 3:
            $countSelect = $this->query("SELECT COUNT(*) as count FROM users INNER JOIN admins ON users.id=admins.uid WHERE users.support=1")->fetch_assoc();
            $admins = $this->query("SELECT users.*,admins.added FROM users INNER JOIN admins ON users.id=admins.uid WHERE users.admin=1 AND users.support=1 AND users.id > $offset ORDER BY id ASC LIMIT $count")->fetch_all( MYSQLI_ASSOC );
        break;
        case 4:
            if($admin['super']){
                $countSelect = $this->query("SELECT COUNT(*) as count FROM users INNER JOIN admins ON users.id=admins.uid WHERE users.admin=1")->fetch_assoc();
                $admins = $this->query("SELECT users.*,admins.added FROM users INNER JOIN admins ON users.id=admins.uid WHERE users.admin=1 AND users.id > $offset ORDER BY id ASC LIMIT $count")->fetch_all( MYSQLI_ASSOC );
            }else{
                $countSelect = $this->query("SELECT COUNT(*) as count FROM users INNER JOIN admins ON users.id=admins.uid WHERE users.admin=1 AND admins.added=?", $admin['id'])->fetch_assoc();
                $admins = $this->query("SELECT users.*,admins.added FROM users INNER JOIN admins ON users.id=admins.uid WHERE users.admin=1 AND admins.added=? AND users.id > $offset ORDER BY id ASC LIMIT $count", $admin['id'])->fetch_all( MYSQLI_ASSOC );
            }
        break;
    }
    if(!is_array($admins)){
        $admins = [];
    }
	$users = [];
	$list = [];
	foreach( $admins as $user ){
		$user['has_control'] = 0;
		$user['super'] = 0;
		if(isset($user['added'])){
		    if(!isset($users[$user['added']])){
		        $added = $this->user($user['added']);
		        if($added){
                    $users[$user['added']] = $this->fields($added, ['id', 'phone', 'admin', 'support'], [], ['phone' => 'login']);
                }
			}
			$user['added'] = isset($users[$user['added']]) ? $users[$user['added']] : $user['added'];
			if($admin['super']||$user['added']['id'] == $admin['id']){
				$user['has_control'] = 1;
			}
		}else{
		    $user['added'] = 0;
		    $user['super'] = 1;
        }
		$list[] = $this->fields($user, ['id', 'phone', 'admin', 'support', 'added', 'super', 'has_control'], [ 'balance', 'password', 'verify_block', 'verify_block_time', 'verify_code', 'verify_created', 'verify_checked' ], ['phone'=>'login']);
	}
	return [
	    'count' => is_array($countSelect) ? $countSelect['count'] : 0,
        'items' => $list
    ];
};