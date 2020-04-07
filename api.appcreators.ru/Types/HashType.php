<?php

declare(strict_types=1);
/**
 * Class HashType
 * @package SimpleEngine\Api
 */
class HashType extends StringType
{
    /**
     * @param $value
     * @return HashType
     */
    public function setValue( string $value )
    {
        $value = strtolower( $value );
        parent::setValue( $value );
        if( $this->error !== false ){
            return $this;
        }
        if( strlen( $this->value ) != 32 ) {
            $this->error = 1;
        }
        $tmp = preg_replace('/^[^a-f0-9]+$/', '', $this->value );
        if( $tmp !== $this->value ){
            $this->error = 2;
        }
        return $this;
    }
}