<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->optional([
	'offset' => 'uint',
	'count' => 'uint',
    'sort' => 'uint'
]);
return function($offset, $count, $sort){
    $sort = in_array($sort, [0, 1, 2, 3, 4]) ? $sort : 0;
	if($count===null || $count < 1){
		$count = 20;
	}
	if($count > 100){
	    $count = 100;
    }
	if($offset===null){
		$offset = 0;
	}
	$admin = $this->admin();
	if( !$admin ){
		return $this->error(0);
	}
	switch($sort){
        case 0:
            $countSelect = $this->query("SELECT COUNT(*) AS count FROM history")->fetch_assoc();
            $histories = $this->query("SELECT * FROM history ". ($offset? "WHERE id < $offset" : "") ." ORDER BY id DESC LIMIT $count")->fetch_all(MYSQLI_ASSOC);
        break;
        case 1:
            $countSelect = $this->query("SELECT COUNT(*) AS count FROM history WHERE type=0")->fetch_assoc();
            $histories = $this->query("SELECT * FROM history WHERE type=0 ". ($offset? "AND id < $offset" : "") ." ORDER BY id DESC LIMIT $count")->fetch_all(MYSQLI_ASSOC);
        break;
        case 2:
            $countSelect = $this->query("SELECT COUNT(*) AS count FROM history WHERE NOT type=0")->fetch_assoc();
            $histories = $this->query("SELECT * FROM history WHERE NOT type=0 ". ($offset? "AND id < $offset" : "") ." ORDER BY id DESC LIMIT $count")->fetch_all(MYSQLI_ASSOC);
        break;
        case 3:
            $countSelect = $this->query("SELECT COUNT(*) AS count FROM history WHERE type=2")->fetch_assoc();
            $histories = $this->query("SELECT * FROM history WHERE type=2 ". ($offset? " id < $offset" : "") ." ORDER BY id DESC LIMIT $count")->fetch_all(MYSQLI_ASSOC);
        break;
        case 4:
            $countSelect = $this->query("SELECT COUNT(*) AS count FROM history WHERE type=3")->fetch_assoc();
            $histories = $this->query("SELECT * FROM history WHERE type=3 ". ($offset? " id < $offset" : "") ." ORDER BY id DESC LIMIT $count")->fetch_all(MYSQLI_ASSOC);
        break;
    }
	if(!is_array($histories)){
		return $this->error(1);
	}
	$list = [];
	$users = [];
	foreach($histories as $history){
		$uid = $history['uid'];
		if(!isset($users[$uid])){
			$user = $this->call('profile.get', ['id' => $uid]);
			if($user){
			    if(isset($user['error'])&&$user['error']['code']==1){
                    $user = $this->call('admin.profile.get', [ 'id' => $uid] );
                }
			    if($user&&!isset($user['error'])){
                    $users[$uid] = $user;
                    $history['uid'] = $user;
                }
			}
		}else{
			$history['uid'] = $users[$uid];
		}
		$list[] = $this->fields($history, [], [], ['uid'=>'user']);
	}
	return [
	    'count' => is_array($countSelect) ? $countSelect['count'] : 0,
        'items' => $list
    ];
};