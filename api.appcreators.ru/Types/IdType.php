<?php

declare(strict_types=1);
/**
 * Class IdType
 * @package SimpleEngine\Api
 */
class IdType extends IntType
{
    /**
     * @param string $value
     * @return IdType
     */
    public function setValue( string $value )
    {
        parent::setValue( $value );
        if( $this->error !== false ){
            return $this;
        }
        $value = $this->value;
        if( $value <= 0 ){
            $this->error = 1;
        }
        return $this;
    }
}