<?php

declare(strict_types=1);

namespace SimpleEngine;

use ReflectionFunction;
use ReflectionException;
use SimpleEngine\Api\Exception;
use SimpleEngine\Api\Param;
use \Closure;

/**
 * Class Api
 * @package SimpleEngine
 */
class Api extends EmptyObject
{
    private string $_methodsPath;
    private string $_modulesPath;
    private string $_version;
    private array $_required;
    private array $_optional;

    /**
     * Api constructor.
     * @param string $methodsPath
     * @param string $modulesPath
     * @param string $version
     * @throws Exception
     */
    public function __construct( string $methodsPath = '', string $modulesPath = '', string $version = '' )
    {
        $this->_required = [];
        $this->_optional = [];
        $this->setMethodsPath( $methodsPath )->setModulesPath( $modulesPath )->setVersion( $version );
    }

    /**
     * @param $prop
     * @param $value
     * @return Api
     */
    public function __set( $prop, $value )
    {
        if( parent::__set( $prop, $value ) ){
            return $this;
        }
        $this->{$prop} = $value;
        return $this;
    }
    /**
     * @param $module
     * @return Closue
     * @throws Exception
     */
    public function getModule( $module )
    {
        if( !$this->modulesPath ){
            throw new Exception("Modules directory not installed");
        }
        if( !is_dir( $this->modulesPath ) ){
            mkdir($this->modulesPath);
            if( !is_dir( $this->modulesPath ) ){
                throw new Exception("Modules directory '{$this->modulesPath}' not found");
            }
        }
        $filename = $this->modulesPath . '/' . $module . '.php';
        if( !file_exists( $filename ) ){
            $filename = $this->modulesPath . str_replace('_', '/', $module) . '.php';
            if( !file_exists( $filename ) ){
                throw new Exception("Module '$module' not found");
            }
        }
        $moduleClosure = require $filename;
        if( is_object( $moduleClosure ) ){
            return $moduleClosure;
        }
        if( !is_callable( $moduleClosure ) ){
            throw new Exception( "Module '$module' should return object or closure function" );
        }
        return null;
    }

    /**
     * @param $module
     * @return mixed|null
     * @throws Exception
     */
    public function __get( $module )
    {
        $get = parent::__get( $module );
        if( $this == $get ){
            $moduleClosure = $this->getModule( $module );
            if( is_callable( $moduleClosure ) ){
                return call_user_func_array( $moduleClosure, $args );
            }
            return $moduleClosure;
        }
        return $get;
    }
    /**
     * @param $module
     * @param $args
     * @return mixed
     * @throws Exception
     */
    public function __call( $module, $args )
    {
        if( property_exists( $this, $module ) && is_object( $this->{$module} ) && is_callable( $this->{$module} ) ){
            return call_user_func_array( $this->{$module}, $args );
        }
        $moduleClosure = $this->getModule( $module );
        if( is_callable( $moduleClosure ) ){
            return call_user_func_array( $moduleClosure, $args );
        }
        return null;
    }

    /**
     * @param array $params
     * @param array $args
     * @param bool $required
     * @return array
     * @throws Api\Exception
     * @throws Exception
     */
    private function checkParams( array $params = [], array $args = [], bool $required = true )
    {
        $allParams = [];
        $childParams = [];
        foreach( $params as $name => $type ){
            if( gettype( $name ) != 'string' ){
                throw new Exception( 'An array of parameters was expected with parameter names in keys' );
            }
            if( !is_string( $type ) ){
                throw new Exception( "Param '$k' must be of type string" );
            }
            $childParam = false;
            $originalName = $name;
            if( strpos( $name, '.' ) ){
                $childParam = true;
                $name = str_replace('.','_', $name );
            }
            $param = new Param();
            $param->name = $name;
            $param->type = $type;
            if( $childParam ){
                $childParams[$originalName] = $param;
            }else{
                $allParams[$name] = $param;
            }
        }
        foreach( $childParams as $name => $param ){
            $parents = explode( '.', $name );
            $fullParent = false;
            for( $i = 0; $i < count( $parents ) - 1; $i++ ){
                $parent = $parents[$i];
                if( !$fullParent ){
                    $fullParent = $parent;
                }else{
                    $fullParent .= '_' . $parent;
                }
                if( !isset( $args[$fullParent] ) ) {
                    return $this->error( 0, [ 'type' => 'PARAM', 'name' => $fullParent ] );
                }
            }
            $allParams[str_replace('.', '_', $name )] = $param;
        }
        foreach( $allParams as $name => $param ){
            if( $required && !isset( $args[$name] ) ){
                return $this->error(1, [ 'type' => 'PARAM', 'name' => $name ] );
            }
            if( !$required && !isset($args[$name]) ){
                unset($allParams[$name]);
                continue;
            }
            $param->value = (string)$args[$name];
            if( $param->error !== false ) {
                return $this->error( $param->error, [ 'type' => 'TYPE', 'param' => [ 'name' => $name, 'type' => strtolower( $param->type ) ] ] );
            }
            $allParams[$name] = $param->value;
        }
        return $allParams;
    }

    /**
     * @param string $method
     * @param string $version
     * @return array
     * @throws Exception
     */
    private function getMethod( string $method, string $version = '' )
    {
        if( !preg_match('/^[A-z0-9.]+$/', $method ) ){
            return $this->error(0, 'API');
        }
        if( $this->methodsPath === null ){
            throw new Exception('Methods directory not installed' );
        }
        if( !is_dir( $this->methodsPath ) ){
            mkdir( $this->methodsPath );
            if( !is_dir( $this->methodsPath ) ){
                throw new Exception( "Methods directory '{$this->methodsPath}' not found" );
            }
        }
        if( $version != null ){
            $this->setVersion( $version );
        }
        $filename = $this->methodsPath . '/' . str_replace( '.', '/', $method ) . '.php';
        if( !file_exists( $filename ) ) {
            return $this->error(1, 'API');
        }
        $methodClosure = require $filename;
        if( !is_callable( $methodClosure ) ){
            throw new Exception( "Method '$method' should return closure function" );
        }
        return $methodClosure;
    }

    /**
     * @param Closure $method
     * @param array $params
     * @return array|mixed
     * @throws Api\Exception
     * @throws Exception
     * @throws ReflectionException
     */
    private function callMethod( Closure $method, array $params = [], array $noCheck = [] )
    {
        $requiredParams = $this->checkParams( $this->required, $params );
        if( isset( $requiredParams['error'] ) ){
            return $requiredParams;
        }
        $optionalParams = $this->checkParams( $this->optional, $params, false );
        if( isset( $optionalParams['error'] ) ){
            return $optionalParams;
        }
        $allParams = array_merge( $requiredParams, $optionalParams, $noCheck );
        $reflection = new ReflectionFunction( $method );
        $newParams = [];
        foreach( $reflection->getParameters() as $parameter )
            $newParams[] = isset( $allParams[$parameter->name] ) ? $allParams[$parameter->name] : null;
        return call_user_func_array( $method, $newParams );
    }

    /**
     * @param string $method
     * @param array $params
     * @param string $version
     * @return array|mixed
     * @throws Api\Exception
     * @throws Exception
     * @throws ReflectionException
     */
    public function call( string $method, array $params = [], string $version = '' )
    {
        $this->required = [];
        $this->optional = [];
        $result = $this->getMethod( $method, $version );
        if( is_callable( $result ) ){
            return $this->callMethod( $result, $params );
        }
        return $result;
    }

    /**
     * @param array $required
     * @param array $optional
     * @return $this
     */
    public function params( array $required = [], array $optional = [] )
    {
        $this->required = $required;
        $this->optional = $optional;
        return $this;
    }

    /**
     * @param array $required
     * @return $this
     */
    public function required( array $required = [] )
    {
        $this->required = $required;
        return $this;
    }

    /**
     * @param array $optional
     * @return $this
     */
    public function optional( array $optional = [] )
    {
        $this->optional = $optional;
        return $this;
    }

    /**
     * @param array $params
     * @return $this
     */
    public function setRequired( array $params )
    {
        $this->_required = $params;
        return $this;
    }

    /**
     * @return array
     */
    public function getRequired()
    {
        return $this->_required;
    }

    /**
     * @param array $params
     * @return $this
     */
    public function setOptional( array $params )
    {
        $this->_optional = $params;
        return $this;
    }

    /**
     * @return array
     */
    public function getOptional()
    {
        return $this->_optional;
    }

    /**
     * @param $a
     * @param $b
     * @return int
     */
    private function compareVersion( $a, $b )
    {
        if( !preg_match('/[0-9][0-9.]*/', $a ) ){
            return -3;
        }
        if( !preg_match('/[0-9][0-9.]*/', $b ) ){
            return -2;
        }
        $al = count( explode( '.', $a ) );
        $bl = count( explode( '.', $b ) );
        if( $al != $bl ){
            $pos = $al > $bl ? true : false;
            $s = $pos ? $bl : $al;
            $e = $pos ? $al : $bl;
            for( $i = $s + 1; $i <= $e; $i++ ){
                ${$pos ? 'b' : 'a'} .= '.0';
            }
        }
        $a = (int)str_replace('.','0', $a );
        $b = (int)str_replace( '.', '0', $b );
        if( $a < $b )
            return -1;
        if( $a > $b )
            return 1;
        return 0;
    }

    /**
     * @param $version
     * @return bool
     * @throws Exception
     */
    public function version( string $version )
    {
        if( $this->version === null ){
            return false;
        }
        if( strlen( $version ) ){
            if( strpos( $version, '!' ) !== false || strpos( $version,  '>' ) !== false || strpos( $version, '<' ) !== false ){
                $statements = [ '!', '<', '>' ];
                $i = 0;
                $l = strlen( $version );
                while( $i < $l ){
                    $chr = $version[$i];
                    if( in_array( $chr, $statements ) ){
                        $find = [];
                        $a = strpos( $version, '!', $i + 1 );
                        $b = strpos( $version, '<', $i + 1 );
                        $c = strpos( $version, '>', $i + 1 );
                        if( $a !== false ) {
                            $find[] = $a;
                        }
                        if( $b !== false ){
                            $find[] = $b;
                        }
                        if( $c !== false ){
                            $find[] = $c;
                        }
                        sort( $find );
                        $value = !count( $find ) ? substr( $version, $i + 1 ) : substr( $version, $i + 1, $find[0] - $i - 1 );
                        if( strlen( $value ) > 0 && $value[0] == '=' ){
                            $chr .= '=';
                            $value = substr( $value, 1 );
                        }
                        if( !strlen( $value ) ){
                            throw new Exception("Incorrect version in statement '$chr'" );
                        }
                        switch( $chr ){
                            case '<=':
                                $result = $this->compareVersion( $this->version, $value );
                                if( $result !== -1 && $result !== 0 ) {
                                    return false;
                                }
                                break;
                            case '>=':
                                $result = $this->compareVersion( $this->version, $value );
                                if( $result !== 1 && $result !== 0 ) {
                                    return false;
                                }
                                break;
                            case '<':
                                if( $this->compareVersion( $this->version, $value ) !== -1 )
                                    return false;
                                break;
                            case '>':
                                if( $this->compareVersion( $this->version, $value ) !== 1 )
                                    return false;
                                break;
                            case '!':
                                if( $this->compareVersion( $this->version, $value ) === 0 )
                                    return false;
                                break;
                        }
                        $i += strlen( $value ) + strlen( $chr );
                    }
                }
                return true;
            }
            return $this->compareVersion( $this->version, $version ) === 0 ? true : false;
        }
        return false;
    }

    /**
     * @param $code
     * @param string|array $data
     * @return array
     */
    public function error( $code, $data = [] )
    {
        $error = [ 'code' => $code ];
        if( is_string( $data ) ){
            $data = [ 'type' => $data ];
        }elseif( !is_array( $data ) )
            $data = [];
        if( !isset( $data['type'] ) ){
            $data['type'] = 'METHOD';
        }
        return [
            'error' => array_merge( $error, $data )
        ];
    }

    /**
     * @param $version
     * @return $this
     * @throws Exception
     */
    public function setVersion( string $version = '' )
    {
        if( $version != '' ){
            $regex = '/^[0-9][0-9\.]*+$/';
            if (!preg_match($regex, $version)) {
                throw new Exception("Version doesn't match regex '$regex'");
            }
            $this->_version = $version;
        }
        return $this;
    }

    /**
     * @return mixed
     */
    public function getVersion()
    {
        return $this->_version;
    }

    /**
     * @param string $value
     * @return $this
     */
    public function setMethodsPath( string $value = '' )
    {
        $this->_methodsPath = $value;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getMethodsPath()
    {
        return $this->_methodsPath;
    }

    /**
     * @param string $value
     * @return $this
     */
    public function setModulesPath( string $value = '' )
    {
        $this->_modulesPath = $value;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getModulesPath()
    {
        return $this->_modulesPath;
    }
}