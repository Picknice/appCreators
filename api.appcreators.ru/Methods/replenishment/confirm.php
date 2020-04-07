<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->params([
   'id' => 'id'
]);
return function($id){
    $user = $this->user();
    if(!$user){
        return $this->error(0);
    }
    $replenishment = $this->query("SELECT * FROM replenishments WHERE id=?", $id)->fetch_assoc();
    if(!$replenishment){
        return $this->error(1);
    }
    if(!$this->query([
        [ "UPDATE users SET balance=balance + {$replenishment['value']} WHERE id=?", $replenishment['uid'] ],
        [ "UPDATE replenishments SET status=2 WHERE id=?", $replenishment['id'] ]
    ])){
        return $this->error(2);
    }
    return true;
};