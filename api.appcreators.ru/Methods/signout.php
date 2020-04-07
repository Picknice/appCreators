<?php

declare(strict_types=1);
$this->app(APP_TYPE_STANDALONE);
return function(){
	return $this->query("DELETE FROM app_sessions WHERE id=?", $this->session['id']);
};