<?php

declare(strict_types=1);
use SimpleEngine\Api\Type;
/**
 * Class boolType
 * @package SimpleEngine\Api
 */
class boolType extends Type
{
    public function __construct()
    {
        parent::__construct( function( $value ){
            if($value==""){
                $value = 'false';
            }
            if( $value === 'true' || $value === 'false' ){
        		if( $value === 'true' ){
        			$value = '1';
        		}
        		if( $value === 'false' ){
        			$value = '0';
        		}
        		$this->originalValue = $value;
        	}
        	return boolval($value);
        } );
    }
}