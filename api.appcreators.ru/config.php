<?php

declare(strict_types=1);
$this->db = new mysqli( 'localhost', 'root', '5f4324bf' );
$this->db->select_db( 'db' );
$this->db->set_charset('utf8' );
$this->rules->generate( [ 'APP_TYPE_SERVICE', 'APP_TYPE_WEBSITE', 'APP_TYPE_STANDALONE' ] , 'APP_TYPE_ALL' );
$this->rules->generate( [ 'TOKEN_TYPE_PROFILE' ], 'TOKEN_TYPE_ALL' );