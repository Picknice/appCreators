<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->optional([
    'offset' => 'uint',
    'count' => 'uint',
    'sort' => 'uint'
]);
return function($offset, $count, $sort){
    $sort = in_array($sort, [0, 1, 2]) ? $sort : 0;
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
    switch($sort){
        case 0:
            $countSelect = $this->query("SELECT COUNT(*) as count FROM users WHERE admin=0")->fetch_assoc();
            $users = $this->query("SELECT * FROM users WHERE admin=0 AND id > $offset LIMIT $count")->fetch_all( MYSQLI_ASSOC );
        break;
        case 1:
            $countSelect = $this->query("SELECT COUNT(*) as count FROM users WHERE admin=0 AND NOT rent=0")->fetch_assoc();
            $users = $this->query("SELECT * FROM users WHERE admin=0 AND NOT rent=0 AND id > $offset LIMIT $count")->fetch_all( MYSQLI_ASSOC );
        break;
        case 2:
            $countSelect = $this->query("SELECT COUNT(*) as count FROM users WHERE admin=0 AND rent=0")->fetch_assoc();
            $users = $this->query("SELECT * FROM users WHERE admin=0 AND rent=0 AND id > $offset LIMIT $count")->fetch_all( MYSQLI_ASSOC );
        break;
    }
    if(!is_array($users)){
        return $this->error(1);
    }
    $list = [];
    foreach( $users as $user ){
        if($user['rent']){
            $rent = $this->call('rent.get', [ 'id' => $user['rent'], 'extended' => false ] );
            if(is_array($rent)&&!isset($rent['error'])){
                $user['rent'] = $rent;
            }
        }
        $list[] = $this->fields( $user, ['id', 'phone', 'balance', 'created', 'rent'], ['password'], [], ['rent'] );
    }
    return [
        'count' => is_array($countSelect) ? $countSelect['count'] : 0,
        'items' => $list
    ];
};