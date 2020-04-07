<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->optional([
    'offset' => 'uint',
    'count' => 'uint',
    'sort' => 'uint'
]);
return function($offset, $count, $sort){
    $sort = in_array($sort, [0, 1, 2, 3]) ? $sort : 0;
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
    if(!$admin){
        return $this->error(0);
    }
    if(!$sort){
        $countSelect = $this->query("SELECT COUNT(*) as count FROM replenishments")->fetch_assoc();
        $replenishments = $this->query("SELECT * FROM replenishments".($offset?" WHERE id < $offset":"")." ORDER BY id DESC LIMIT $count")->fetch_all( MYSQLI_ASSOC );
    }else{
        $sort = $sort - 1;
        $countSelect = $this->query("SELECT COUNT(*) as count FROM replenishments WHERE status=?", $sort)->fetch_assoc();
        $replenishments = $this->query("SELECT * FROM replenishments WHERE status=?".($offset?" AND id < $offset":"")." ORDER BY id DESC  LIMIT $count", $sort)->fetch_all( MYSQLI_ASSOC );
    }
    if(!is_array($replenishments)){
        return $this->error(1);
    }
    $list = [];
    foreach( $replenishments as $replenishment ){
        if($replenishment['uid']){
            $userProfile = $this->call("profile.get", [ 'id' => $replenishment['uid'] ]);
            if($userProfile && !isset($userProfile['error'])){
                $replenishment['uid'] = $userProfile;
            }
        }
        $list[] = $this->fields($replenishment, [], [], ["uid" => "user"]);
    }
    return [
        'count' => is_array($countSelect) ? $countSelect['count'] : 0,
        'items' => $list
    ];
};