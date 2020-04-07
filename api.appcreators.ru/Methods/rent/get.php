<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->params([
    'id' => 'int'
], [
    'extended' => 'bool'
]);
return function($id, $extended){
    $extended === true ? true : false;
    $rent = $this->query("SELECT * FROM rents WHERE id=?", $id)->fetch_assoc();
    if(!$rent){
        return $this->error(0);
    }
    if($extended){
        $user = $this->call("profile.get", [ 'id' => $rent['uid'] ]);
        if(is_array($user)&&!isset($user['error'])){
            $rent['uid'] = $user;
        }
    }
    return $this->fields($rent, [], [], [ 'uid' => 'user']);
};