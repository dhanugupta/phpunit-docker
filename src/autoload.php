<?php

    function my_autoloader($class) {
        include 'classes/' . $class . '.php';
    }

    spl_autoload_register('my_autoloader');

    // Or, using an anonymous function as of PHP 5.3.0
    spl_autoload_register(function ($class) {
        include 'classes/' . $class . '.php';
    });

    ?>