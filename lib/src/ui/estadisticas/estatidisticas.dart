/*
 * Autor: jmlgomez73
 */

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:reactions/src/funcions/main_highscores.dart';
import 'package:reactions/src/models/highscore.dart';
import 'package:reactions/src/models/tipos_modos.dart';

class Estadisticas extends StatefulWidget {
  @override
  _EstadisticasState createState() => _EstadisticasState();
}

class _EstadisticasState extends State<Estadisticas> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MainHighscores mainHighscores = Provider.of<MainHighscores>(context);

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: new Text(
          "Un Jugador",
          textAlign: TextAlign.center,
        ),
      ),
      body:
          //ESTADISTICAS 1 JUGADOR
          Container(
        child: Material(
          child: StreamBuilder<List<Highscore>>(
              stream: mainHighscores.highscore$,
              builder: (context, snapshot) {
                if (!snapshot.hasData && snapshot.data == null) {
                  return Container(child: Text('No data avaible right now'));
                } else {
                  String testHighscore = snapshot.data
                      .firstWhere((test) => test.tipo == TiposModos.Test,
                          orElse: () => null)
                      .getTimeCorrectly;
                  print(testHighscore);
                  String mejorde3Highscore = snapshot.data
                      .firstWhere((test) => test.tipo == TiposModos.Mejorde3,
                          orElse: () => null)
                      .getTimeCorrectly;
                  String mejorde5Highscore = snapshot.data
                      .firstWhere((test) => test.tipo == TiposModos.Mejorde5,
                          orElse: () => null)
                      .getTimeCorrectly;

                  return Container(
                    color: ThemeData.dark().buttonColor,
                    child: Column(children: <Widget>[
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: HighscoreTile(
                                  tipo: "Test", time: testHighscore))),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: HighscoreTile(
                                  tipo: "Mejor de 3",
                                  time: mejorde3Highscore))),
                      Expanded(
                          child: HighscoreTile(
                              tipo: "Mejor de 5", time: mejorde5Highscore)),
                    ]),
                  );
                }
              }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

//Se encarga de devolver el container de cada modo
class HighscoreTile extends StatelessWidget {
  final String tipo;
  final String time;

  HighscoreTile({Key key, this.tipo, this.time}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
      color: ThemeData.dark().primaryColor,
      elevation: 12.0,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  tipo.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  (time == '' || time == null) ? "0" : time,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
        ),
      ),
    ));
  }
}
