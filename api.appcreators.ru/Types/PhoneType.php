<?php

declare(strict_types=1);
/**
 * Class PhoneType
 * @package SimpleEngine\Api
 */
class PhoneType extends StringType
{
    /**
     * @param string $value
     * @return PhoneType
     */
    public function setValue( string $value )
    {
        parent::setValue( $value );
        if( $this->error !== false ){
            return $this;
        }
        if(!preg_match('/^[0-9]{7,25}$/', $this->value)){
            $this->error = 1;
            return $this;
        }
        $this->value = $value;
        return $this;
    }
}