<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
return function(){
	$user = $this->user();
	if( !$user['admin'] ){
		return $this->error(0);
	}
	return $this->query("DELETE FROM app_sessions WHERE id=?", $this->session['id']);
};