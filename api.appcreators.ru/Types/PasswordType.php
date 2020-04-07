<?php

declare(strict_types=1);
/**
 * Class PasswordType
 * @package SimpleEngine\Api
 */
class PasswordType extends StringType
{
    /**
     * @return PasswordType
     */
    public function setValue( string $value )
    {
        parent::setValue( $value );
        if( $this->error !== false ){
            return $this;
        }
        if(!preg_match('/^[\w_]{8,32}$/', $this->value )){
            $this->error = 1;
            return $this;
        }
        $this->value = password_hash( $this->value, PASSWORD_DEFAULT);
        return $this;
    }
}