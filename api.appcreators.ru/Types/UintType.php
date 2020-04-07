<?php

declare(strict_types=1);
use SimpleEngine\Api\Type;
/**
 * Class UintType
 * @package SimpleEngine\Api
 */
class UintType extends Type
{
    public function __construct()
    {
        parent::__construct( function( $value ){
            $value = intval( $value );
            if( $value < 0 )
                $this->error = 1;
            if( $value > PHP_INT_MAX )
                $this->error = 2;
            return $value;
        } );
    }
}