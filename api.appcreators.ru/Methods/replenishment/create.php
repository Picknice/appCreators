<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->params([
   'value' => 'uint'
]);
return function($value){
    $user = $this->user();
    if(!$user){
        return $this->error(0);
    }
    if($this->query("INSERT INTO replenishments (uid,value,created) VALUES (?,?,?)", $user['id'], $value, time())){
        return $this->query->db->insert_id;
    }
    return $this->error(1);
};