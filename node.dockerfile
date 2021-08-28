# Build: docker build -f node.dockerfile -t danwahlin/nodeapp .

# Option 1: Create a custom bridge network and add containers into it

# docker network create --driver bridge isolated_network
# docker run -d --net=isolated_network --name mongodb mongo

# NOTE: $(pwd) in the following line is for Mac and Linux. See https://blog.codewithdan.com/docker-volumes-and-print-working-directory-pwd/ for Windows examples.
# docker run -d --net=isolated_network --name nodeapp -p 3000:3000 -v $(pwd)/logs:/var/www/logs danwahlin/nodeapp

# Seed the database with sample database
# Run: docker exec nodeapp node dbSeeder.js

# Option 2 (Legacy Linking - this is the OLD way)
# Start MongoDB and Node (link Node to MongoDB container with legacy linking)
 
# docker run -d --name my-mongodb mongo
# docker run -d -p 3000:3000 --link my-mongodb:mongodb --name nodeapp danwahlin/nodeapp

FROM        node:alpine

LABEL       author="Javier Ramos"

ENV         NODE_ENV=production
ENV         PORT=3000

WORKDIR     /var/www
COPY        package.json package-lock.json ./
RUN         npm install

# Lo mismo que  COPY . . 
# o que         COPY . /var/www
COPY        . ./
EXPOSE      $PORT

ENTRYPOINT  ["npm", "start"]

# docker build -t <name> .
# docker build --tag <name> .
# docker build -t <registry>/<name>:<tag> .
# docker build -t jaramosdal/nodeapp:1.0 -f node.dockerfile .

# docker images                                                         List Docker images
# docker rmi <imageId>                                                  Remove an image
                        
# docker push <username>/<imagename>:<tag>                      
                        
# docker run -p 8080:80 -d nginx:alpine                                 Crea una instancia de contenedor a partir de la imagen nginx:alpine
                        
# docker ps                                                             Muestra todos los contenedores que están corriendo
# docker ps -a                                                          Muestra todos los contenedores
                        
# docker stop <id>                                                      Parar un contenedor
# docker rm <id>                                                        Borrar un contenedor

# docker logs <containerId>                                             View Container Logs


# Volumes 
# docker run -p 8080:80 -v ${pwd}:/usr/share/nginx/html nginx:alpine
# docker run -p 3000:3000 -v ${PWD}/logs:/var/www/logs jaramosdal/nodeapp:1.0

# Networks 
# docker network create
# docker network ls
# docker network rm [network]
# docker network create --driver bridge isolated_network

# unsa red bridge permite a containers dentro de la misma red comunicarse entre sí

# docker run -d --net=isolated_network --name=mongodb mongo
# docker run -d -p 3000:3000 --net=isolated_network --name=nodeapp -v ${PWD}/logs:/var/www/logs jaramosdal/nodeapp:1.0

# docker network inspect <networkId>


# Shell into a Container
# docker exec -it <containerId> [sh, bash, PowerShell] 
# docker exec -it <containerId> sh 