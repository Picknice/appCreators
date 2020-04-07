<?php
declare(strict_types=1);
if( !property_exists( $this, '_query' ) ){
    $mysqlWrapper = new class{
        public $query;
        public $db;

        /**
         *  constructor.
         */
        public function __construct()
        {
            $this->db = null;
        }

        /**
         * @param $prop
         * @param $value
         */
        public function __set( $prop, $value )
        {
            if( $prop == 'db' && is_object( $value ) && is_a( $value, 'mysqli' ) )
                $this->db = $value;
        }

        /**
         * @param $prop
         * @return mixed
         */
        public function __get( $prop )
        {
            return $this->db->{$prop};
        }

        /**
         * @param $method
         * @param $args
         * @return mixed
         */
        public function __call( $method, $args )
        {
            if( $this->db ){
                return call_user_func_array([$this->db, $method], $args);
            }
            return $this;
        }

        /**
         * @return bool|false|mysqli_result
         */
        public function query()
        {
            $args = func_get_args();
            $num = func_num_args();
            if( !$this->db ){
                throw new Exception( 'Database connection not established' );
            }
            $this->query = array_shift( $args );
            $stmt = $this->db->prepare( $this->query );
            $countPrepareParams = mb_substr_count( $this->query, '?' );
            if( $countPrepareParams + 1 != $num ){
                throw new Exception("Expected {$countPrepareParams} parameters instead of " . ( $num - 1 ) . " in query '{$this->query}'" );
            }
            if( $stmt ){
                if( $num > 1 ){
                    $types = '';
                    $data = [ $types ];
                    $callbacks = [];
                    $arr = [];
                    foreach( $args as $k => $arg ){
                        if( is_array( $arg ) )
                            $arr[] = json_encode( $arg );
                        else
                            $arr[] = $arg;
                    }
                    foreach( $arr as $k => $arg ){
                        switch( gettype( $arg ) ){
                            case 'integer': $types .= 'i'; break;
                            case 'double': $types .= 'd'; break;
                            case 'string': $types .= 's'; break;
                            default : $types .= 'b'; break;
                        }
                        $data[] = &$arr[$k];
                    }
                    $data[0] = $types;
                    call_user_func_array( [ $stmt, 'bind_param' ], $data );
                }
                $stmt->execute();
                if($this->db->error){
                    trigger_error($this->db->error);
                    return false;
                }
                if( $stmt->insert_id != 0 )
                    return true;
                if( $stmt->affected_rows != -1 )
                    return $stmt->affected_rows != 0;
                return $stmt->get_result();
            }
            return false;
        }
        /**
         * @return bool
         */
        public function queryEx( array $queries = [] )
        {
            if( !count( $queries ) ){
                return false;
            }
            try{
                $this->db->autocommit(false);
                foreach( $queries as $query ){
                    call_user_func_array( [ $this, 'query' ], $query );
                }
                if($this->db->error){
                    trigger_error($this->db->error);
                    return false;
                }
                $this->db->commit();
                return true;
            }catch( Exception $e ){
                $this->db->rollback();
            }
            return false;
        }
    };
    if( $this->db ){
        $mysqlWrapper->db = $this->db;
    }
    $this->query = $mysqlWrapper;
}
return function(){
    $args = func_get_args();
    if( count( $args ) > 0 && is_array( $args[0] ) ){
        return call_user_func_array( [ $this->query, 'queryEx' ], $args );
    }
    return call_user_func_array( [ $this->query, 'query' ], $args );
};