<?php

declare(strict_types=1);
return new class{
    /**
     * @param array $rules
     * @param string $all
     */
    public function generate( array $rules = [], string $all = '' )
    {
        $count = count( $rules );
        $tmp = 0;
        for( $i = 0; $i < $count; $i++ ){
            $value = 1 << $i;
            $rule = $rules[$i];
            if( defined( $rule ) ){
                throw new Exception( "Constant rule '$rule' already defined" );
            }
            if( $tmp != 0 )
                $tmp |= $value;
            else
                $tmp = $value;
            define( $rule, $all == '' && $i == $count - 1 ? $tmp : $value );
        }
        if( $all != '' )
            define( $all, $tmp );
    }

    /**
     * @param int $all
     * @param int $rules
     * @return bool
     */
    public function check( int $all = 0, int $rules = 0 )
    {
        if( !$all || !$rules )
            return true;
        if( $all & $rules == 0 )
            return false;
        return true;
    }
};