# Docker 🐳

Son agrupaciones de procesos que estan aislado del resto del mundo, permitiendonos resolver problemas de cosntrucción, distribución y ejecución de software en diferentes plataformas.

![Alt text](https://lh3.googleusercontent.com/proxy/3HRlWJor7WSWWJqUC8BC7b-FT9m-AZhpqIkIudiWFkJPuYLT_H1XocxSThUb35LdBa0Sg8QjfyKKXDstcN5ojy-Z94YH4Ct4lnX75J8VT1zQaHKA "Optional Title")

## Instalar docker 💾

[Instalar docker](https://docs.docker.com/engine/install/)

### 🤔 ¿Como funciona Docker?🤔

### ¿Qué es un contenedor?

Es una entidad logica que no tiene limites que ejecuta sus procesos de forma nativa, de uno o mas procesos. Es una pieza fundamental de docker.

![Alt text](https://blog.carreralinux.com.ar/wp-content/uploads/2020/06/docker_imagenes_contenedores.png "Optional Title")

Los procesos de un contenedor, no conoce más allá de lo que se le permite, y solo tiene acceso al directorio que se le permite ver, no sabe que existe algo mas.

### Algunos comandos en docker ⌨

```bash
docker ps -a # lista todos los procesos,-a muestra todo el conenido
```

```bash
docker inspect <id> o <name> # Inspecciona un contenedor
```

```bash
docker inspect -f  #-f filtra información
```

```bash
docker rename <old_name> <new_name> #Renombrar un contenedor
```

```bash
docker run <name> # Crear un contenedor
```

```bash
docker logs <name> # Ver el output contenedores
```

```bash
docker rm  <name> # Borrar un contenedor
```

```bash
docker rm $(docker ps -aq) # Borrar todos los contenedores
```

```bash
docker exec -it  <name> # Ejecutar un proceso de un contenedor existente,
 el it es el modo iterativo
```

```bash
docker rm -f <name> #Salir del modo iterativo,
 aqui mata el contenedor asi se este ejecutando
```

Exponiendo contenedores 🌎

```bash
docker run -d --name <name> image

-d es dettach, lo que hace es que el contenedor no me arroje un output,
 si no que lo deje en modo interactivo
```

Para que un contenedor se comunique con el mundo exterior hay que configurar su network, y esto se hace con la ayuda de los ports.

```bash
docker run -d --name <name> -p 3000:80 image
# -p indica el puerto
```

🕵 3000:80, en este caso el puerto 3000(izq) es el de mi máquina y el 80(derecha) es el puerto de la red.

```bash
docker run --name <name> -d -v path:where
 # montar un directorio de archivos a un contenedor.
-v volume.
```

## ¿Que son los volumes? 🧐

Volume es uno de los tipos de formatos de docker para preservar la data, almacenarán los ficheros que copiemos a ese contenedor.Los volumes son una evolucion del bind mount

Usará el espacio de nuestro equipo real y en “/var/lib/docker/volumes” creará una carpeta para cada contenedor, toda la informacion de nuestros contenedores estaran en el mismo sitio, haciendolo mas facil su migracion de una pc a otra.

![Alt text](https://miro.medium.com/max/624/1*j0g82wL5oUl3dgwIXZBIpA.png "Optional Title")

- tmpfs mount: es el unico que no peresiste la data, es ideal para cuando manejamos informacion sensible.

-bind mount: Hace persistencia de datos, es parecido al volume solo que este guarda la informacion en todo el fileSystem y no en un sitio en especifico, por eso volumen es una evolución de los bind mounts.

```bash
docker volume ls # Listar volume
```

```bash
docker volume prune #Borrar los volumenes que no estan en uso
```

```bash
docker volume create mis_datos # Crear un volumen
```

## Imagenes

Son plantillas o templates de contenedores, y a partir de estas imagenes se generan los contenedores que vamos a usar.

Las imagenes son un conjunto de capas o layers y todo parte de una capa base
y capas que se van montando sobre ella.
Las imagenes en docker son inmutable, es decir, que cada capa que se va montando sobre una imagen es añadiendole algo a la capa anterior.

```bash
docker pull image # Trae una image que no tenemos
```

```bash
docker image ls # Lista las imagenes.
```

## Construir una imagen.

```bash
FROM  node:12 # from es la base de nuestra imagen.
Node es la imagen en su version 12.
```

```bash
RUN  npm install # Correr un comando
```

```bash
build .
#  es el CONTEXT del path y todo ese path se le da al deamon,
# y usa todo lo que hay ahí en tiempo de build
```

Con el comando build hace una imagen, y a partir de la imagen hace un contenedor.

```bash
COPY ['.', 'usr/src/'] # parte del contenxto de build
# y copia todo lo que esta en el build
```

El copy se copia los archivos que son afectados por el comando run, ahi se dice que afecta todos, pero _package.json_ package.lock.json\* no son afectados siempre.

```bash
# esto es para que no se repite si hacemos build varias veces
COPY ["package.json", "package-lock.json", "/usr/src/"]
```

```bash
CMD ["npx", "nodemon", "index.js"]
#Se define el comando por defecto que va a correr el contenedor
# chequear los archivos
# que cuando haya uno nuevo se reinicie
```

```bash
EXPOSE 3000 # exponer el puerto
```

## Otros comandos de ayuda en docker ☝️

```bash
docker run -it <nombre-image> #correr la imagen
```

```bash
docker run -d --name container image #conectar una imagen con un contenedor
```

```bash
docker network inspect nombre_networ --name #ver si un contenedor esta conectado

```

```bash
docker run -d --name <nombre_contenedor> -p 3000:3000 --env VARIABLE_NOMBRE= URL_VARIABLE <nombre_image>

# -env: agregar una variable de entorno.
```

```bash
docker networkn <network-name> <contaniner-name> #Conectar dos contenedores entre si
```

# 🐳 Docker Compose 🐳

Es una herramienta que nos permite describir de forma declarativa la arquitectura de nuestra app

docker-compose.yml <-- en este archivo.

- Versión : Que ocupe la version.

- Servicios: Se habla de servicios, no de contenedores. Un servicio puede tener mas de un contendor.

  Dentro de servicios esta:
  -image: Nombre de la imagen.

  - enviroment: .env, es lo equivalente a añadir variables de entorno.
  - depend_on: que este servicio depende de otro servicio.
    -ports: puertos.

- volumes: una lista de descripción de como queremos usar los volumenes
  ```bash
      - .:/usr/src #que vaya a los directorios a hacer una correción
      # QUE ESTO NO ME LO TOQUE NO SE REISCRIBA NI NADA
      - /usr/src/node_modules
      # esto lo que hace es que solo se buildee a menos que haya algo nuevo
  ```

## Comando de docker-compose ☝️

```bash
docker-compose up -d
```

```bash
docker-compose ps
```

```bash
docker-compose logs
```

```bash
docker-compose exec <name_serv>
```

```bash
docker-compose exec <name_serv> bash
```

```bash
docker-compose build #ejecuta todo lo que ya conocemos
```

```bash
docker-compose down # tumbar/eliminar los servicios
```

```bash
docker-compose scale <name_services>=5 # que escale a cinco contenedores.
```

## Docker ignore ⬛

Nos permite excluir archivos que no queremos en la imagen final, cuando se hace el build.

```bash
*.log
.dockerignore
.git
.gitignore
build/*
Dockerfile
node_modules
npm-debug.log*
README.md

```
