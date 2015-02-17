#!/bin/bash

phpunit --configuration /var/www/test/phpunit.xml

set -e -x
echo "starting supervisor in foreground"
supervisord -n