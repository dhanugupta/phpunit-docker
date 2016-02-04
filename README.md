# phpunit-docker
phpunit and code coverage via docker container

# Docker Build Image:

docker build -t phpunittest .

# Docker Run

docker run --name phpunittest -d -p 9000:80 -v /data/servers/build:/var/www/build phpunittest 

# After Run

1. It will generate "coverage" folder under build
2. It will generate "logs" folder under build
3. You can source clover files to sonar qube for code coverage

# Sonarqube Integration

Problem:  Phpunit coverage generates full path to the files in clover xml/Junit reports. Sonarqube can't able to analyse the data.

### Solution: You can use the ''sed'' unix command to replace the full path the relavtive path.

Examples:
sed -i.bkp 's/\/home\/b\/dv\/.jenkins_cc_slave\/workspace\/phpunit-build\/src/\/home\/b\/dv\/.jenkins_cc_slave\/workspace\/phpunit-codequality\/src/g' clover.xml

OR

docker run -v ${WORKSPACE}:/var/www --rm=true x.x.x.x:8080/webserver/develop /bin/bash -c '/var/www/bin/build.sh && /var/www/bin/phpunit -c /var/www'
sed -i "s|/var/www|${WORKSPACE}|g" ${WORKSPACE}/build/logs/clover.xml




