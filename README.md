<h1 align="center">Reactions</h1>

## Descripción

Reactions es una aplicación con la que podrás comprobar tus reflejos y obtener en milisegundos o segundos tu velocidad de reacción.
La aplicación fue hecha con el framework de Flutter y programada en Dart.

## Construido con 🛠️

* [Flutter](https://flutter.dev/) - SDK.
* [VS Code](https://code.visualstudio.com/) - Editor

## Diseño

* Patrón BLoC — Para separar la logica de la interfaz
* StreamController de Dart — Para comunicar los intents de la UI.
* StreamBuilder de Flutter — Para disparar las actualizaciones de la UI.


<h1 align="center">Características</h1>

<h2 align="center">Número de jugadores</h2>

<h3 align="center">1 Jugador</h3>

  * Los mejores resultados que obtengas serán guardados en el apartado de Estadísticas

<h3 align="center">2 Jugadores</h3>

  * Cada uno tendréis vuestra pantalla. Dadle al botón central para comenzar y después de obtener cada resultado para seguir, si vuestro modo es Mejor de 3 o Mejor de 5. En este caso no se guardarán estadísticas.
  
<h2 align="center">Modos</h2>

<h3 align="center">Test</h3>

  * Aquí tendrás un intento.
  Después de darle a Comenzar, cuando la pantalla se ponga verde, pulsa lo mas rápido que puedas.

<h3 align="center">Mejor de 3</h3>

  * Cuentas con 3 intentos.
  Obtendrás resultados después de cada uno y al final obtendrás una media.
  
<h3 align="center">Mejor de 5</h3>

  * Cuentas con 5 intentos.
  Obtendrás resultados después de cada uno y al final obtendrás una media.

<h2 align="center">Funciones</h2>
  
  * __Bate tu record!! , Cuanto menor sea más rápido eres!!__
    * Sistema de Estadisticas accesible desde la barra inferior de la aplicación.
    * Highscore medido en segundos o milisegundos para cada modo (Sólo para modo 1 Jugador).
    
  * __Guardado de records__
    * Almacenaje de records en shared preferences.
    * Recuperación de los records al iniciar la aplicación.
    * CodificaciÓn y decodificación JSON.

  * __Menú de navegación inferior__
    * Accede a Estadisitcas, Informacion o vuelve al Menu inicial.
    
  * __Información interesante y estudio sobre los reflejos y tiempos de reacción humanos__
    
<h1 align="center">Demostración</h1>

<p align="center"><img src="http://g.recordit.co/apiQl5Rote.gif"></p>


## Funcionando para ⚙️

Versiones Android 4.1+ (API:16) hasta Android 10+ (API:30)

## Ejecutar codigo

* Pasos
  * 1 - Descarga el proyecto y abrelo en un editor como por ejemplo Visual Studio Code y descarga los paquetes de flutter y dart.
  * 2 - Descarga todos paquetes y dependencias , utilizando el comando ```flutter pub get```.
  * 3 - Utiliza un AVD con nivel de API superior a 14.
  * 4 - Ejecuta el codigo en el AVD creado previamente.
  
### APK 🔧

Puedes descargar la APK desde el apartado "Releases".

## Autor ✒️

* **Jorge Manuel Lozano Gómez**
