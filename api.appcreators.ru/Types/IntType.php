<?php

declare(strict_types=1);
use SimpleEngine\Api\Type;
/**
 * Class IntType
 * @package SimpleEngine\Api
 */
class IntType extends Type
{
    public function __construct()
    {
        parent::__construct( function( $value ){
            $value = intval( $value );
            if( $value < PHP_INT_MIN )
                $this->error = 1;
            if( $value > PHP_INT_MAX )
                $this->error = 2;
            return $value;
        } );
    }
}