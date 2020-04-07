<?php

declare(strict_types=1);
return function( array $data = [] ) {
    if( !count( $data ) ){
        $data = [ md5( (string)mt_rand( 1, 10000000 ) ), uniqid() ];
    }
    return md5( implode( '', $data ) );
};