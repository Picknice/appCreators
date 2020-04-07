<?php

declare(strict_types=1);
/**
 * Class LoginType
 * @package SimpleEngine\Api
 */
class LoginType extends StringType
{
    /**
     * @param $value
     * @return LoginType
     */
    public function setValue( string $value )
    {
        parent::setValue( $value );
        if( $this->error !== false ){
            return $this;
        }
        if( !preg_match( '/^[A-z]{1,1}[A-z0-9_]{1,15}$/', $this->value ) ){
            $this->error = 2;
        }
        return $this;
    }
}