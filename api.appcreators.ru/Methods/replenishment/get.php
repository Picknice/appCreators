<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->optional([
    'offset' => 'uint',
    'count' => 'uint'
]);
return function($offset, $count){
    $user = $this->user();
    if(!$user){
        return $this->error(0);
    }
    if($count===null || $count < 1){
        $count = 20;
    }
    if($count > 100){
        $count = 100;
    }
    if($offset===null){
        $offset = 0;
    }
    $countSelect = $this->query("SELECT COUNT(*) as count FROM replenishments WHERE uid=? AND status=2", $user['id'])->fetch_assoc();
    $replenishments = $this->query("SELECT * FROM replenishments WHERE uid=? AND status=2".($offset?" AND id < $offset":"")." ORDER BY id DESC LIMIT $count", $user['id'])->fetch_all( MYSQLI_ASSOC );
    if(!is_array($replenishments)){
        return $this->error(1);
    }
    $list = [];
    foreach( $replenishments as $replenishment ){
        $list[] = $this->fields($replenishment, [], ['uid']);
    }
    return [
        'count' => is_array($countSelect) ? $countSelect['count'] : 0,
        'items' => $list
    ];
};