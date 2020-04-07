<?php

declare(strict_types=1);
$this->app( APP_TYPE_SERVICE );
$this->params( [
	'phone' => 'phone'
] );
$this->methodType = false;
return function($phone){
	$user = $this->query( "SELECT * FROM users WHERE phone=?", $phone )->fetch_assoc();
	if( !$user ){
		return $this->error(1);
	}
	return $user['verify_code'];
};
