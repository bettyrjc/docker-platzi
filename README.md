# Docker 🐳

Son agrupaciones de procesos que estan aislado del resto del mundo, permitiendonos resolver problemas de cosntrucción, distribución y ejecución de software en diferentes plataformas.

![Alt text](https://lh3.googleusercontent.com/proxy/3HRlWJor7WSWWJqUC8BC7b-FT9m-AZhpqIkIudiWFkJPuYLT_H1XocxSThUb35LdBa0Sg8QjfyKKXDstcN5ojy-Z94YH4Ct4lnX75J8VT1zQaHKA "Optional Title")

## Instalar docker 💾

[Instalar docker](https://docs.docker.com/engine/install/)

### 🤔 ¿Como funciona Docker?🤔

### ¿Qué es un contenedor?

Es una entidad logica que no tiene limites que ejecuta sus procesos de forma nativa, de uno o mas procesos. Es una pieza fundamental de docker.

![Alt text](https://blog.carreralinux.com.ar/wp-content/uploads/2020/06/docker_imagenes_contenedores.png "Optional Title")

Los procesos de un contenedor, no conoce mas alla de lo que se le permite, y solo tiene acceso al directorio que se le permite ver, no sabe que existe algo mas.

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
