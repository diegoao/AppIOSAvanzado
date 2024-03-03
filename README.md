
# Práctica APP IOS AVANZADO

Práctica realizada para el módulo de IOS AVANZADO por Diego Andrades.

**KeepCoding - Profesor Pedro.**

Para este módulo se ha integrado coreData y KeyChain para guardar el token.
Se ha implementado testing.


## API Reference

#### Obtener todos los items

```http
  https://dragonball.keepcoding.education/api/heros/
```

## Información

La práctica consta de varias pantallas:
| ![Simulador1](https://github.com/diegoao/AppIOSAvanzado/blob/main/IMAGENES%20README/LOGIN.png) | ![Simulador2](https://github.com/diegoao/AppIOSAvanzado/blob/main/IMAGENES%20README/LISTADOHEROES.png) | ![Simulador3](https://github.com/diegoao/AppIOSAvanzado/blob/main/IMAGENES%20README/DETALLEHEROE.png) | ![Simulador4](https://github.com/diegoao/AppIOSAvanzado/blob/main/IMAGENES%20README/DETALLE%20TRANSFORMACION.png) |
| --- | --- | --- | --- | 
| 1 | 2 | 3 | 4 | 

```
1. Login -> Pantalla en la cual tenemos que logearnos.
Previamente tenemos que crearnos un usuario en la API. Si
obtenemos un error al ingresar el usuario o contraseña nos
saldrá un mensage de error. Si iniciamos sesion no volverá
a salir hasta que pulsemos el botón logOut!
```
```
2. Lista de héroes -> Al obtener el token con nuestro usuario
y contraseña accederemos a la lista de héroes donde podremos
ver todos los personajes incluidos en la Api. Al realizar clic
sobre ellos se nos abrirá la pantalla de Detalles.
```
```
3.Detalle Héroe -> Podemos ver la foto y una descripción del héroe su localización y en un CollectionView todas sus transformaciones.
```
```
4. Detalle Transformación -> Podemos ver la foto y una descripción de la transformación.
```
```

## Autor

- [@Diego](https://github.com/diegoao)

