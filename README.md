# Docker!!!

Permite resolver problemas en construir, distribuir y ejecutar software en diferentes plataformas

# Containarizacion

los **contenedores** son un entidad logica, que agrupan procesos que se ejecutan de forma nativa como cualquier otra aplicacion

Se le dice entidad logica, porque no tiene un limite estricto.
Es un estandar para llevar algo dentro de agrupadores de proceso
son:
-Versatiles,
-Eficientes,
-Aislado

Docker se encarga de:
**Construir** **Distribuir** **Ejecutar** codigo en cualquier lado.

# Comandos

**docker ps** Lista todos los documentos.
**docker ps -aq** esto muestra solos id
**docker inspect nombre_contenedor** inspeccionar
**docker inspect -f '{{json.Config.Env}} nombre_contendor** Filtrar
**docker rena nombre_viejo nombre_nuevo** renombrar container
**docker rm nombre_contenedor** borrar un contenedor
**docker \$(docker ps -aq)** borrar todos los contenedores.

**docker run -it nombre_contenedor** correr el contenedor en la terminal.
**docker rm -f nombre_contenedor** apaga el proceso, lo apaga y lo elimina.
**docker kill nombre_contenedor** mata el proceso.

## Exponiendo un contenedor al mundo exterior

Los contenedores estan aislados del sistema y a nivel de red, cada contenedor tiene su propio stack de net y sus propios puertos.
**docker run -d --name server -p 8080:80 nombre_contenedor** Redirije a los puertos y crea.

- -p indica el puerto.
- 8080: es el puerto de la pc.
- 80 es el puerto de la net.

## Volumes

Nos ayuda a mantener todo organizado
**docker volume ls**
**docker volume prune** borra los volumenes que estan en uso por ningun contenedor

### Crear un volume

mount src=nombre_volumen
**docker run -d --name name --mount src=nombre_volumen dts=/data/name mongo**

## Imagenes

Son un componente fundamental de docker y sin ellas los contenedores no tendrian sentido. **son fundamentalmen plantillas o templates**
Una vez creada, no cambian.

Estan construidas de una capa base y se van montando capas sobre ellas.

- Cada capa es inmutable

**docker image ls** listar las imagenes
**docker pull image:version** cuando te quieres traer una imagen, en una version especifica.

### Construyendo nuestras propias imagenes

Se necesita **Dockerfile**
FROM node:12

- esto es para que no se repite si hacemos build varias veces
  COPY ["package.json", "package-lock.json", "/usr/src/"]
  WORKDIR /usr/src
  RUN npm install --only=production
  COPY [".", "/usr/src/"]
  RUN npm install --only=development
  EXPOSE 3000

- chequear los archivos que cuando haya uno neuvo se reinicie
  CMD ["npx", "nodemon", "index.js"]

**docker build -t npmbre_imagen** construir la imagen.
**docker run -it nombre_imagen** correr la imagen.
-crear
**docker network create --attachable nombre_net**
**docker network connect nombre_net nombre_contenedor**
**docker inspect nombre_net** aqui vemos que nombre

# Docker compose

Es una herramienta que nos permite describir de forma declarativa la arquitectura de nuestra aplicacion, utiliza compose (docker-compose.yml)

Es una herramienta que nos permite describir de forma declarativa la arquitectura de nuestra app.

**docker rm -f \$(docker ps -aq)** tumbar o borrar todo.
**docker network rm nombre_net** borrar network
Los servicios es un componente que sirve a la totalidad de las aplicaciones, diferencias entre un servicio u un contenedor, es que en un servicio puede haber mas de un contenido.

-depends_on: es cuando un servicio depende de otro
**docker-compose up -d** ese flag de d, es un dittach
**docker-compose ps**
**docker-compose logs app** solo ve los de un servicio.
**docker-compose exec app bash**

## docker multi stage build

nos permite usar docker files donde tiene varias fases de build, pero esto se puede conectar entre ellos.
**docker build -z nombre -f url**
Tambien existe _docker in docker_ que se esta desde un container hablandole al docker deamon que esta en nuestra maquina

Crear la imagen de docker, la primera vez que vamos a ejecutar el proyecto o cuando agregamos un nuevo paquete al package.json debemos hacer un build.
docker-compose -f docker-compose.local.yml build

2. Luego que termine podemos levantar el proyecto con:
   docker-compose -f docker-compose.local.yml up

3. Para tumbar el proyecto basta con dartle CTRL + C, pero si una dependencia no te agarra despues de hacer el build debes tumbar todo el proyecto para que se elimine el contenedor viejo, esto lo hacemos con:
   docker-compose -f docker-compose.local.yml down

Hay dos formas de agregar una nueva dependencia, la primera es agregandola directo en el package.json de forma manual o ejecutando el siguiente comando:
docker-compose -f docker-compose.local.yml run --rm app npm install --save PAQUETE

Un ejemplo:
docker-compose -f docker-compose.local.yml run --rm app npm install --save node-sass
