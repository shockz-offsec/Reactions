/*
 * Autor: jmlgomez73
 */

import 'dart:async';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:reactions/src/funcions/main_highscores.dart';
import 'package:reactions/src/models/estados.dart';
import 'package:reactions/src/models/highscore.dart';
import 'package:reactions/src/models/tipos_modos.dart';
import 'package:flutter/material.dart';
import 'package:reactions/src/funcions/tester.dart';
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class UnJugador extends StatefulWidget {
  TiposModos tipo; //Tipod de juego (TEST, ...)

  UnJugador(this.tipo, {Key key}) : super(key: key);

  @override
  _UnJugadorState createState() => _UnJugadorState();
}

class _UnJugadorState extends State<UnJugador> {
  Tester tester;
  Random rng = Random();
  MaterialColor colorPantalla;
  String texto = '';
  String textoIntento = '';
  String resultTimeText = '';
  int numeroIntento = 0;
  String textoAvg = '';
  Stopwatch stopwatch;
  Duration tiempoEspera;
  List<double> arrayIntentos = new List();
  Timer _timer = Timer(Duration(minutes: 0), () => {});

  void initState() {
    super.initState();
    tester = Tester();
    colorPantalla = Colors.blue;
    numeroIntento = 0;
    arrayIntentos = new List();
  }

  @override
  Widget build(BuildContext context) {
    final MainHighscores mainHighscores = Provider.of<MainHighscores>(context);

    return StreamBuilder<MapEntry<Estados, double>>(
        stream: Observable.combineLatest2(
          tester.estados$,
          tester.resultTime$,
          (a, b) => MapEntry(a, b),
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final state = snapshot.data.key;
          final resultTime =
              snapshot.data.value - 100; //100 lag input del movil

          //Comprueba si ha batido record
          if (state == Estados.Resultados && TiposModos.Test == widget.tipo) {
            mainHighscores
                .checkHighscore(Highscore(tipo: widget.tipo, time: resultTime));
          }

          //Gestiono variables
          if (widget.tipo == TiposModos.Mejorde3 &&
              state == Estados.Resultados &&
              numeroIntento != 3) {
            numeroIntento++;
            arrayIntentos.add(resultTime);
          }

          //Comprueba si ha batido record
          if (state == Estados.Resultados &&
              TiposModos.Mejorde3 == widget.tipo &&
              numeroIntento == 3) {
            mainHighscores.checkHighscore(Highscore(
                tipo: widget.tipo,
                time: getAverage(widget.tipo, numeroIntento)));
          }

          //Gestiono variables
          if (widget.tipo == TiposModos.Mejorde5 &&
              state == Estados.Resultados &&
              numeroIntento != 5) {
            arrayIntentos.add(resultTime);
            numeroIntento++;
          }

          //Comprueba si ha batido record
          if (state == Estados.Resultados &&
              TiposModos.Mejorde5 == widget.tipo &&
              numeroIntento == 5) {
            mainHighscores.checkHighscore(Highscore(
                tipo: widget.tipo,
                time: getAverage(widget.tipo, numeroIntento)));
          }

          unJugadorInfoSet(state, widget.tipo, resultTime);

          return GestureDetector(
            onTap: () {
              if (_timer.isActive) {
                _timer.cancel();
                tester.nextScreen(Estados.ErrorToque);
              } else {
                tester.nextScreen(state);
              }

              //Reseteo variables
              if (state == Estados.Resultados &&
                  TiposModos.Mejorde3 == widget.tipo &&
                  numeroIntento == 3) {
                numeroIntento = 0;
                textoAvg = '';
                arrayIntentos = new List();
              }

              //Reseteo variables
              if (state == Estados.Resultados &&
                  TiposModos.Mejorde5 == widget.tipo &&
                  numeroIntento == 5) {
                numeroIntento = 0;
                textoAvg = '';
                arrayIntentos = new List();
              }
            },
            child: Material(
              color: colorPantalla,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 110.0),
                          child: (() {
                            if (state == Estados.Resultados) {
                              return textoAux(texto + "\n", resultTimeText, 35,
                                  Alignment.center, Colors.white);
                            } else {
                              return textoAux(texto, "", 30, Alignment.center,
                                  Colors.white);
                            }
                          }())),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: (() {
                            if (state == Estados.Resultados) {
                              return textoAux(textoIntento, "", 30,
                                  Alignment.center, Colors.white);
                            } else {
                              return Text("");
                            }
                          }())),
                    ),
                    Container(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: (() {
                            if (state == Estados.Resultados) {
                              return textoAux(textoAvg, "", 30,
                                  Alignment.center, Colors.white);
                            } else {
                              return Text("");
                            }
                          }())),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  //Muestra los textos
  Widget textoAux(String texto, String texto2, double tam, Alignment align,
      Color colorAux) {
    if (texto != "Pulsa cuando la pantalla se ponga verde") {
      if (texto2 == "") {
        return Stack(
          alignment: align,
          children: <AutoSizeText>[
            AutoSizeText(
              texto,
              style: TextStyle(
                fontSize: tam,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 4
                  ..color = Colors.black,
              ),
              maxLines: 1,
            ),
            AutoSizeText(
              texto,
              style: TextStyle(
                fontSize: tam,
                color: colorAux,
              ),
              maxLines: 1,
            ),
          ],
        );
      } else {
        return Stack(
          alignment: align,
          children: <AutoSizeText>[
            AutoSizeText(
              texto,
              style: TextStyle(
                fontSize: tam,
                foreground:
                    Paint() //foreground es para derle el borde negro a la fuente.  El funcionamiento va por pares, 1 foregroudn 1 texto normal
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = Colors.black,
              ),
              maxLines: 2,
            ),
            AutoSizeText(
              texto,
              style: TextStyle(
                //La propia fuente
                fontSize: tam,
                color: colorAux,
              ),
              maxLines: 2,
            ),
            AutoSizeText(
              "\n" + texto2,
              style: TextStyle(
                fontSize: tam,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 4
                  ..color = Colors.black,
              ),
              maxLines: 2,
            ),
            AutoSizeText(
              "\n" + texto2,
              style: TextStyle(
                fontSize: tam,
                color: colorAux,
              ),
              maxLines: 2,
            ),
          ],
        );
      }
    } else {
      return Stack(
        alignment: align,
        children: <Widget>[
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: tam,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 4
                  ..color = Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: 'Pulsa cuando la pantalla se ponga ',
                    style: TextStyle(color: Colors.black)),
                TextSpan(text: 'verde ', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: tam),
              children: <TextSpan>[
                TextSpan(
                    text: 'Pulsa cuando la pantalla se ponga ',
                    style: TextStyle(color: Colors.white)),
                TextSpan(text: 'verde ', style: TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ],
      );
    }
  }

  //Gestion de textos de los estados
  void unJugadorInfoSet(Estados state, TiposModos tipo, double resultTime) {
    switch (state) {
      case Estados.Comienzo:
        colorPantalla = Colors.blue;
        texto = "Pulsa para comenzar!!";
        break;

      case Estados.Espera:
        colorPantalla = Colors.pink;

        texto = "Pulsa cuando la pantalla se ponga verde";

        tiempoEspera = Duration(milliseconds: next(1500, 5500));
        _timer = Timer(tiempoEspera, () => tester.nextScreen(state));
        break;

      case Estados.Toque:
        colorPantalla = Colors.green;
        texto = "Dalee!";

        break;

      case Estados.Resultados:
        colorPantalla = Colors.blue;
        texto = "Tu tiempo de reacción fue:";
        resultTimeText = resultTimeTest(resultTime);
        if (TiposModos.Mejorde3 == tipo) {
          textoIntento = "Intento " + (numeroIntento).toString() + "/3";
          if (numeroIntento == 3)
            textoAvg = "Media: " + getAverageText(widget.tipo, numeroIntento);
        } else if (TiposModos.Mejorde5 == tipo) {
          textoIntento = "Intento " + (numeroIntento).toString() + "/5";
          if (numeroIntento == 5)
            textoAvg = "Media: " + getAverageText(widget.tipo, numeroIntento);
        }
        break;

      case Estados.ErrorPantalla:
        colorPantalla = Colors.red;
        texto = "Muy pronto!!";
        break;

      default:
        colorPantalla = Colors.blue;
        texto = "Pulsa para comenzar!!";
    }
  }

  //Encargada de diferenciar entre s y ms, y transformar el valor obtenido para modo Test//
  String resultTimeTest(double resultTime) {
    String resultTimeFinal = (resultTime / 1000).toStringAsFixed(3);
    if (resultTime < 1000) {
      resultTimeFinal = (resultTime.toInt()).toString() + " ms!";
    } else {
      resultTimeFinal = resultTimeFinal + " segundos!";
    }
    return resultTimeFinal;
  }

  //Devuelve la media para el modo Mejor de 3 y 5
  double getAverage(TiposModos tipo, int numIntento) {
    double averageFinal = 0;

    if (tipo == TiposModos.Mejorde3 && numIntento == 3) {
      var sum = arrayIntentos.reduce((a, b) => a + b);
      averageFinal = sum / 3;
    } else if (tipo == TiposModos.Mejorde5 && numIntento == 5) {
      var sum = arrayIntentos.reduce((a, b) => a + b);
      averageFinal = sum / 5;
    }

    averageFinal = averageFinal / 1000;
    averageFinal = double.parse(averageFinal.toStringAsFixed(3));
    averageFinal = averageFinal * 1000;

    return averageFinal;
  }

  //Devuelve en texto la media para el modo Mejor de 3 y 5
  String getAverageText(TiposModos tipo, int numIntento) {
    String averageFinalText = '';
    double average = 0;

    if (tipo == TiposModos.Mejorde3 && numIntento == 3) {
      var sum = arrayIntentos.reduce(( a, b,) => a + b);
      average = sum / 3;
    } else if (tipo == TiposModos.Mejorde5 && numIntento == 5) {
      var sum = arrayIntentos.reduce((a, b) => a + b);
      average = sum / 5;
    }

    if (average < 1000) {
      averageFinalText =
          (average / 1000).toStringAsFixed(3).split('.')[1].substring(0, 3) +
              " ms!";
    } else {
      averageFinalText = (average / 1000).toStringAsFixed(3) + " Segundos!";
    }

    if (average == 0) {
      return '';
    } else {
      return averageFinalText;
    }
  }
}

int next(int min, int max) => min + Random().nextInt(max - min);
