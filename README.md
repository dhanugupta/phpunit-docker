# phpunit-docker
phpunit and code coverage via docker container

# Docker Build Image:

docker build -t phpunittest .

# Docker Run

docker run --name phpunittest -d -p 9000:80 -v /data/servers/build:/var/www/build phpunittest 



