<?php


class ProductTest extends PHPUnit_Framework_TestCase
{
    function testBasis()
    {
        $instance = new Product(1);

        $this->isInstanceOf('Product',$instance);
        $this->assertEquals($instance->get_id(), 1);
    }
}

?>