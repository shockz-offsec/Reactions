/*
 * Autor: jmlgomez73
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabbar/tabbar.dart';

class Informacion extends StatefulWidget {
  @override
  _InformacionState createState() => _InformacionState();
}

class _InformacionState extends State<Informacion> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = PageController();

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        bottom: PreferredSize(
          //Para omitir el hueco del AppBar
          preferredSize: Size.fromHeight(0),
          child: TabbarHeader(
            controller: controller,
            tabs: [
              Tab(text: "Como Jugar"),
              Tab(text: "Información"),
              Tab(text: "Contacto"),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/fondo_reactions.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: TabbarContent(controller: controller, children: <Widget>[
          //Tab1
          SingleChildScrollView(
            //para permitir que la pantalla sea scrollable
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: texto(
                        'Reactions es una aplicación con la que podrás comprobar tus reflejos y obtener en milisegundos o segundos tu reacción',
                        25,
                        Alignment.centerLeft,
                        Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: texto(
                        "Nº DE JUGADORES", 40, Alignment.center, Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: texto(
                        "1 JUGADOR", 35, Alignment.centerLeft, Colors.yellow),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: texto(
                        "Los mejores resultados que obtengas seran guardados en Estadísticas",
                        25,
                        Alignment.center,
                        Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: texto(
                        "2 JUGADORES", 35, Alignment.centerLeft, Colors.yellow),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: texto(
                        "Cada uno tendréis vuestra pantalla.\nDadle al boton central para comenzar y despues de obtener cada resultado para seguir si vuestro modo es Mejor de 3 o Mejor de 5\nEn este caso no se guardarán estadísticas",
                        25,
                        Alignment.center,
                        Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: texto(
                        "MODOS DE JUEGO", 45, Alignment.center, Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child:
                        texto("TEST", 35, Alignment.centerLeft, Colors.yellow),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: texto(
                        "Aquí tendrás un intento.\nDespués de darle a Comenzar, cuando la pantalla se ponga verde, pulsa lo mas rápido que puedas",
                        25,
                        Alignment.center,
                        Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: texto(
                        "Mejor de 3", 35, Alignment.centerLeft, Colors.yellow),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: texto(
                        "Cuentas con 3 intentos.\nObtendrás resultados despues de cada uno y al final obtendrás una media",
                        25,
                        Alignment.center,
                        Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: texto(
                        "Mejor de 5", 35, Alignment.centerLeft, Colors.yellow),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: texto(
                        "Cuentas con 5 intentos.\nObtendrás resultados despues de cada uno y al final obtendrás una media",
                        25,
                        Alignment.center,
                        Colors.white),
                  ),
                ],
              ),
            ),
          ),
          //Tab2
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: texto(
                        'Los tiempos de reacción promedio del humano frente a un estímulo son:',
                        25,
                        Alignment.centerLeft,
                        Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: texto(
                        'Visual - 250 ms\n\nAuditivo - 170 ms\n\nTáctil - 150ms',
                        35,
                        Alignment.centerLeft,
                        Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: texto(
                        'Esta aplicación mide el tiempo de reacción visual\nAunque dichos tiempos de racción sean lo que se consideran cientificamente, Segun Human Benchmark, se obtuvieron los siguiente datos:',
                        25,
                        Alignment.centerLeft,
                        Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: texto('Tiempo de reacción medio', 25,
                        Alignment.center, Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: texto('273 ms', 35, Alignment.center, Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: texto('Tiempo medio de reacción\n(Mejor de 3/5)', 25,
                        Alignment.center, Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: texto('284ms', 35, Alignment.center, Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: texto(
                        'Hay que considerar que los dispositivos moviles tienen un tiempo de respuesta que va desde 20-100 ms dependiendo de la calidad del mismo , en esta aplicación se tomo en consideración el peor de los casos.',
                        25,
                        Alignment.center,
                        Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: texto(
                        'Gráfica obtenida de Human Benchmark sobre los tiempos de reacción después de realizar 81 millones de tests',
                        25,
                        Alignment.center,
                        Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      alignment: Alignment.center,
                      height: 300,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/chart.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: texto('Gráfica de Human Benchmark', 15,
                        Alignment.center, Colors.white),
                  ),
                ],
              ),
            ),
          ),
          //Tab3
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: texto('Desarrollador :\nJorge Manuel Lozano Gómez',
                        25, Alignment.centerLeft, Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: texto('E-mail de contacto :\njmlgomez73@gmail.com',
                        25, Alignment.centerLeft, Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: texto('Versión de Android minima:\nAndroid 4.1+', 25,
                        Alignment.centerLeft, Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  //Muestra texto
  Stack texto(String texto, double tam, Alignment align, Color color) {
    return Stack(
      alignment: align,
      children: <Widget>[
        // Stroked text as border.
        Text(
          texto,
          style: TextStyle(
            fontSize: tam,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4
              ..color = Colors.black,
          ),
        ),
        // Solid text as fill.
        Text(
          texto,
          style: TextStyle(
            fontSize: tam,
            color: color,
          ),
        ),
      ],
    );
  }

  void dispose() {
    super.dispose();
  }
}
