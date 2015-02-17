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

