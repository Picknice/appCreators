<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->optional([
    'offset' => 'uint',
    'count' => 'uint',
    'sort' => 'uint',
    'filter' => 'uint'
]);
return function($offset, $count, $sort, $filter){
    $sorts = [0, 1, 2, 3, 4, 5]; // все, не активированные, не рабочие, свободные, занятые, забронированные
    if($count===null || $count < 1){
        $count = 20;
    }
    if( $count > 100 ){
        $count = 100;
    }
    if($offset===null){
        $offset = 0;
    }
    $admin = $this->admin();
    if(!$admin){
        return $this->error(0);
    }
    if($filter!==null&&$filter>1){ // 2 types {0, 1}
        $filter = null;
    }
    if($sort===null){
        $countSelect = $this->query("SELECT COUNT(*) as count FROM transports ". ($filter===null?"":"WHERE type=$filter"))->fetch_assoc();
        $transports = $this->query("SELECT * FROM transports WHERE". ($filter===null?"":" type=$filter AND"). " id > $offset LIMIT $count")->fetch_all( MYSQLI_ASSOC );
    }else{
        $sort = in_array($sort, $sorts) ? $sort : 0;
        $countSelect = $this->query("SELECT COUNT(*) as count FROM transports WHERE".($filter===null?"":" type=$filter AND"). " status=?", $sort)->fetch_assoc();
        $transports = $this->query("SELECT * FROM transports WHERE".($filter===null?"":" type=$filter AND"). " status=? AND id > $offset LIMIT $count", $sort)->fetch_all( MYSQLI_ASSOC );
    }
    $count = is_array($countSelect) ? $countSelect['count'] : 0;
    if(!is_array($transports)){
        return $this->error(1);
    }
    $list = [];
    foreach( $transports as $transport ){
        if($transport['uid']){
            $userProfile = $this->call("profile.get", [ 'id' => $transport['uid'] ]);
            if($userProfile && !isset($userProfile['error'])){
                $transport['uid'] = $userProfile;
            }
        }
        $list[] = $this->fields($transport, [], [], ['uid' => 'user'] );
    }
    return [
        'count' => $count,
        'items' => $list
    ];
};