<?php

declare(strict_types=1);

namespace SimpleEngine;

/**
 * Class EmptyObject
 * @package SimpleEngine
 */
abstract class EmptyObject
{
    /**
     * @param $prop
     * @param $value
     * @return EmptyObject
     */
    public function __set( $prop, $value )
    {
        $method = 'set' . $prop;
        if( method_exists( $this, $method ) ) {
            $this->{$method}( $value );
            return true;
        }elseif( property_exists( $this, $prop ) ){
            $this->{$prop} = $value;
            return true;
        }
        return false;
    }

    /**
     * @param $prop
     * @return mixed|null|EmptyObject
     */
    public function __get( $prop )
    {
        $method = 'get' . $prop;
        if( method_exists( $this, $method ) ) {
            return $this->{$method}();
        }
        if( property_exists( $this, $prop ) ){
            return $this->{$prop};
        }
        return $this;
    }
}