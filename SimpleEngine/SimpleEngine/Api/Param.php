<?php

declare(strict_types=1);
namespace SimpleEngine\Api;
use SimpleEngine\EmptyObject;

/**
 * Class Param
 * @package SimpleEngine\Api
 */
class Param extends EmptyObject
{
    private string $paramName;
    private string $paramType;
    private $paramValue;

    /**
     * Param constructor.
     * @param string $name
     * @param string $type
     * @param string $value
     * @throws Exception
     */
    public function __construct( string $name = '', string $type = '', string $value = '' )
    {
        $this->paramName = '';
        $this->paramType = '';
        $this->setName( $name )->setType( $type )->setValue( $value );
    }

    /**
     * @param $name
     * @return Param
     * @throws Exception
     */
    public function setName( string $name = '' )
    {
        if( $name == '' ){
            return $this;
        }
        $regex = '/^[a-z][a-z0-9\_]+$/';
        if( !preg_match( $regex, $name ) ) {
            throw new Exception("Param name doesn't match regex '$regex'" );
        }
        $this->paramName = $name;
        return $this;
    }

    /**
     * @param $type
     * @return $this
     * @throws Exception
     */
    public function setType( string $type = '' )
    {
        $this->paramType = $type;
        return $this;
    }

    /**
     * @return string
     */
    public function getType()
    {
        return $this->paramType;
    }

    /**
     * @param $value
     * @return $this
     * @throws Exception
     */
    public function setValue( string $value = '' )
    {
        if( !is_object( $this->paramValue ) ){
            if( $this->paramType == '' ){
                return $this;
            }
            $this->setType( $this->paramType );
            $type = $this->paramType;
            $classType = "\\{$type}Type";
            if( !class_exists( $classType ) ){
                $type = strtolower( $type );
                $type[0] = strtoupper( $type[0] );
                $classType = "\\{$type}Type";
                if( !class_exists( $classType ) ){
                    throw new Exception( "Param type '{$this->paramType}' not exists" );
                }
            }
            $this->paramValue = new $classType();
            if( !is_subclass_of( $this->paramValue, '\SimpleEngine\Api\Type' ) ){
                throw new Exception("Param type '{$this->paramType}' must inherit from SimpleEngine\Api\Type" );
            }
        }
        $this->paramValue->value = $value;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getValue()
    {
        return is_object( $this->paramValue ) ? $this->paramValue->value : null;
    }

    /**
     * @return int|false
     */
    public function getError()
    {
        return is_object( $this->paramValue ) ? $this->paramValue->error : false;
    }
}