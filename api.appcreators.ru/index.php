<?php
declare(strict_types=1);

error_reporting(E_ALL); // debug

header('Access-Control-Allow-Origin: *' );
header('Content-type: application/json; charset=utf-8' );

spl_autoload_register( function( $className ){
    $path = __DIR__ . '/../SimpleEngine/';
    $className = str_replace( '\\', DIRECTORY_SEPARATOR, $className );
    $filename = $path . $className . '.php';
    if( !file_exists( $filename ) ){
        $classNameEx = $className;
        $classNameEx[0] = strtoupper( $classNameEx[0] );
        $filename = __DIR__ . '/Types/' . $classNameEx . '.php';
        if( !file_exists( $filename ) ){
            $filename = $path . $className . '.php';
        }
    }
    if( !file_exists( $filename ) ){
        throw new Exception( "Class '$className' not exists" );
    }
    include $filename;
} );
$seApi = new SimpleEngine\Api();
$seApi->methodsPath = __DIR__ . '/Methods';
$seApi->modulesPath = __DIR__ . '/Modules';
$seApi->version = '1';
$params = $_REQUEST;
$data = file_get_contents('php://input');
if( mb_strlen( $data ) ){
    $params = @json_decode($data, true);
    if( !is_array( $params ) ){
        $params = [];
    }
}
$method = '';
$version = '';
if( isset( $params['method'] ) ){
    $method = $params['method'];
}
if( isset( $params['v'] ) ){
    $params['version'] = $v;
}
if( isset( $params['version'] ) ){
    $version = $params['version'];
}
try{
    echo json_encode( $seApi->callEx( $method, $params, $version ), JSON_UNESCAPED_UNICODE);
} catch ( Exception $exception ){
    trigger_error( $exception->getMessage() );
}