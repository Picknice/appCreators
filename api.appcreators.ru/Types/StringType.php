<?php

declare(strict_types=1);
use SimpleEngine\Api\Type;

/**
 * Class StringType
 * @package SimpleEngine\Api
 */
class StringType extends Type
{
    public function __construct()
    {
        parent::__construct( function( $value ){
            return strval( $value );
        } );
    }
}