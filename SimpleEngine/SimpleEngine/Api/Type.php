<?php

declare(strict_types=1);

namespace SimpleEngine\Api;
use Closure;
use SimpleEngine\EmptyObject;
/**
 * Class Type
 * @package SimpleEngine\Api
 */
abstract class Type extends EmptyObject
{
    protected $handler;
    protected $currentValue;
    protected $originalValue;
    protected $errorCode;

    /**
     * Type constructor.
     * @param Closure $handler
     * @param string $value
     */
    public function __construct( Closure $handler )
    {
        $this->handler = $handler;
    }

    /**
     * @param $value;
     */
    public function setValue( string $value )
    {
        $this->errorCode = false;
        $this->originalValue = $value;
        if( is_callable( $this->handler ) ){
            $value = call_user_func( $this->handler, $value );
            if( ((is_bool($value)||is_int($value)||is_float($value))&&!$value ? '0' : (string)$value ) !== $this->originalValue ){
                $this->errorCode = 0;
                return $this;
            }
        }
        $this->currentValue = $value;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getValue()
    {
        return $this->errorCode !== false ? null : $this->currentValue;
    }

    /**
     * @param $code
     */
    public function setError( int $code )
    {
        $this->errorCode = $code;
    }

    /**
     * @return int|bool
     */
    public function getError()
    {
        return $this->errorCode;
    }

    /**
     * @return mixed
     */
    public function __toString()
    {
        return (string)( is_object( $this->currentValue ) || is_array( $this->currentValue ) ? json_encode( $this->currentValue ) : $this->currentValue );
    }
}