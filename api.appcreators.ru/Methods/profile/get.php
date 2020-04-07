<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
$this->optional([
	'id' => 'id'
]);
return function($id){
    $self = $this->user();
	$user = $this->user($id);
	if(!$user){
		return $this->error(0);
	}
	$off = [ 'admin', 'support', 'password', 'verify_block', 'verify_block_time', 'verify_code', 'verify_created', 'verify_checked' ];
    if( $this->session['uid'] != $user['id']&&!$this->admin()){
        $user['phone'] = mb_substr( $user['phone'], 0, -4 ) . '****';
        $off[] = 'balance';
    }
	return $this->fields( $user, [], $off );
};