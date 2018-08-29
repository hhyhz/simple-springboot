container=$(docker ps -f name=springbootdemo -q)

if [ ! -n container ] ;then
 docker rm -f $(docker ps -f name=springbootdemo -q)
fi
