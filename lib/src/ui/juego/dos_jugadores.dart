/*
 * Autor: shockz-offsec
 */

import 'dart:async';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:reactions/src/models/estados.dart';
import 'package:reactions/src/models/tipos_modos.dart';
import 'package:flutter/material.dart';
import 'package:reactions/src/funcions/tester.dart';
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class DosJugadores extends StatefulWidget {
  TiposModos tipo; //Tipos de juego (TEST, ...)

  DosJugadores(this.tipo, {Key key}) : super(key: key);

  @override
  _DosJugadoresState createState() => _DosJugadoresState();
}

class _DosJugadoresState extends State<DosJugadores> {
  //Variables compartidas
  MaterialColor colorPantalla;
  //variables de control para no poder comenzar si no se clica
  bool comienzoJugador1 = false;
  bool comienzoJugador2 = false;
  Duration tiempoEspera;

  //Variables jugador 1
  Tester tester;
  String texto = '';
  String textoIntento = '';
  String resultTimeText = '';
  int numeroIntento = 0;
  String textoAvg = '';
  Stopwatch stopwatch;
  int control = 0; //variable de control para no poder comenzar si no se clica
  List<double> arrayIntentos = new List();
  Timer _timer = Timer(Duration(minutes: 0), () => {});

  //Variables jugador 2
  Tester tester1;
  String texto1 = '';
  String textoIntento1 = '';
  String resultTimeText1 = '';
  int numeroIntento1 = 0;
  String textoAvg1 = '';
  Stopwatch stopwatch1;
  int control1 = 0; //variable de control para no poder comenzar si no se clica
  List<double> arrayIntentos1 = new List();
  Timer _timer1 = Timer(Duration(minutes: 0), () => {});

  void initState() {
    super.initState();
    tester = Tester();
    tester1 = Tester();
    colorPantalla = Colors.blue;
    numeroIntento = 0;
    numeroIntento1 = 0;
    arrayIntentos = new List();
    arrayIntentos1 = new List();
    comienzoJugador1 = false;
    comienzoJugador2 = false;
    control = 0;
    control1 = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        body: Column(children: <Widget>[
          Expanded(child: stream1()),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/stripes.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: FlatButton(
              onPressed: () {
                if (control == 0 && control1 == 0) {
                  comienzoJugador1 = true;
                  comienzoJugador2 = true;
                  setState(() {});
                }
              },
              child: Text(""),
            ),
          ),
          Expanded(child: stream2()),
        ]));
  }

  StreamBuilder<MapEntry<Estados, double>> stream1() {
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

          //Control de variables para modos Mejor de 3 y de 5
          if (widget.tipo == TiposModos.Mejorde3 &&
              state == Estados.Resultados &&
              numeroIntento != 3 &&
              !comienzoJugador1) {
            arrayIntentos.add(resultTime);
            numeroIntento++;
          }

          if (widget.tipo == TiposModos.Mejorde5 &&
              state == Estados.Resultados &&
              numeroIntento != 5 &&
              !comienzoJugador1) {
            arrayIntentos.add(resultTime);
            numeroIntento++;
          }

          //Control de variables para modos Mejor de 3 y de 5
          if (state == Estados.Resultados &&
              TiposModos.Mejorde3 == widget.tipo &&
              numeroIntento == 3 &&
              comienzoJugador1) {
            textoAvg = '';
            numeroIntento = 0;
            arrayIntentos = new List();
          }

          if (state == Estados.Resultados &&
              TiposModos.Mejorde5 == widget.tipo &&
              numeroIntento == 5 &&
              comienzoJugador1) {
            textoAvg = '';
            numeroIntento = 0;
            arrayIntentos = new List();
          }

          //Controlo que al darle el boton se ponga en cierta pantalla para comenzar o continuar
          if (state == Estados.Comienzo && comienzoJugador1 && control == 0) {
            tester.nextScreen(state);
            control = 1;
            comienzoJugador1 = false;
          } else if (state == Estados.Resultados &&
              comienzoJugador1 &&
              control == 0) {
            tester.nextScreen(Estados.Comienzo);
            control = 1;
            comienzoJugador1 = false;
          }

          if (state == Estados.Resultados) {
            control = 0;
          }

          unJugadorInfoSet1(state, widget.tipo, resultTime);

          return GestureDetector(
            onTap: () {
              if (_timer.isActive) {
                _timer.cancel();
                tester.nextScreen(Estados.ErrorToque);
              } else if (state != Estados.Comienzo && !comienzoJugador1) {
                tester.nextScreen(state);
              }

              //Controlo que si pulsas premeditadamente y sale Muy pronto puedas volver a empezar
              if (state == Estados.ErrorPantalla) {
                tester.nextScreen(Estados.Comienzo);
              }
            },
            child: RotatedBox(quarterTurns: -2, child: jugador1(state)),
          );
        });
  }

  StreamBuilder<MapEntry<Estados, double>> stream2() {
    return StreamBuilder<MapEntry<Estados, double>>(
        stream: Observable.combineLatest2(
          tester1.estados$,
          tester1.resultTime$,
          (a, b) => MapEntry(a, b),
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final state = snapshot.data.key;
          final resultTime =
              snapshot.data.value - 100; //100 lag input del movil

          if (widget.tipo == TiposModos.Mejorde3 &&
              state == Estados.Resultados &&
              numeroIntento1 != 3 &&
              !comienzoJugador2) {
            arrayIntentos1.add(resultTime);
            numeroIntento1++;
          }

          if (widget.tipo == TiposModos.Mejorde5 &&
              state == Estados.Resultados &&
              numeroIntento1 != 5 &&
              !comienzoJugador2) {
            arrayIntentos1.add(resultTime);
            numeroIntento1++;
          }

          if (state == Estados.Resultados &&
              TiposModos.Mejorde3 == widget.tipo &&
              numeroIntento1 == 3 &&
              comienzoJugador2) {
            textoAvg1 = '';
            numeroIntento1 = 0;
            arrayIntentos1 = new List();
          }

          if (state == Estados.Resultados &&
              TiposModos.Mejorde5 == widget.tipo &&
              numeroIntento1 == 5 &&
              comienzoJugador2) {
            textoAvg1 = '';
            numeroIntento1 = 0;
            arrayIntentos1 = new List();
          }

          if (state == Estados.Comienzo && comienzoJugador2 && control1 == 0) {
            tester1.nextScreen(state);
            control1 = 1;
            comienzoJugador2 = false;
          } else if (state == Estados.Resultados &&
              comienzoJugador2 &&
              control1 == 0) {
            tester1.nextScreen(Estados.Comienzo);
            control1 = 1;
            comienzoJugador2 = false;
          }

          if (state == Estados.Resultados) {
            control1 = 0;
          }
          unJugadorInfoSet2(state, widget.tipo, resultTime);

          return GestureDetector(
            onTap: () {
              if (_timer1.isActive) {
                _timer1.cancel();
                tester1.nextScreen(Estados.ErrorToque);
              } else if (state != Estados.Comienzo && !comienzoJugador2) {
                tester1.nextScreen(state);
              }

              if (state == Estados.ErrorPantalla) {
                tester1.nextScreen(Estados.Comienzo);
              }
            },
            child: jugador2(state),
          );
        });
  }

  //Gestion de textos de los estados Jugador 1
  void unJugadorInfoSet1(Estados state, TiposModos tipo, double resultTime) {
    switch (state) {
      case Estados.Comienzo:
        colorPantalla = Colors.blue;
        if (numeroIntento == 0) {
          texto = "Dale para comenzar!!";
        } else {
          texto = "Dale para continuar!!";
        }
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
        texto = "Dale para comenzar!!";
    }
  }

//Gestion de textos de los estados Jugador 2
  void unJugadorInfoSet2(Estados state, TiposModos tipo, double resultTime) {
    switch (state) {
      case Estados.Comienzo:
        colorPantalla = Colors.blue;
        if (numeroIntento1 == 0) {
          texto1 = "Pulsa para comenzar!!";
        } else {
          texto1 = "Pulsa para continuar!!";
        }
        break;

      case Estados.Espera:
        colorPantalla = Colors.pink;

        texto1 = "Pulsa cuando la pantalla se ponga verde";

        _timer1 = Timer(tiempoEspera, () => tester1.nextScreen(state));
        break;

      case Estados.Toque:
        colorPantalla = Colors.green;
        texto1 = "Dalee!";

        break;

      case Estados.Resultados:
        colorPantalla = Colors.blue;
        texto1 = "Tu tiempo de reacción fue:";
        resultTimeText1 = resultTimeTest(resultTime);
        if (TiposModos.Mejorde3 == tipo) {
          textoIntento1 = "Intento " + (numeroIntento1).toString() + "/3";
          if (numeroIntento1 == 3)
            textoAvg1 =
                "Media: " + getAverageText1(widget.tipo, numeroIntento1);
        } else if (TiposModos.Mejorde5 == tipo) {
          textoIntento1 = "Intento " + (numeroIntento1).toString() + "/5";
          if (numeroIntento1 == 5)
            textoAvg1 =
                "Media: " + getAverageText1(widget.tipo, numeroIntento1);
        }
        break;

      case Estados.ErrorPantalla:
        colorPantalla = Colors.red;
        texto1 = "Muy pronto!!";

        break;

      default:
        colorPantalla = Colors.blue;
        texto1 = "Pulsa para comenzar!!";
    }
  }

//Layout del Jugador 1
  Material jugador1(Estados state) {
    return Material(
      color: colorPantalla,
      child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 30, top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: comienzo(state, texto, resultTimeText),
              ),
              Expanded(
                  child: Container(
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
                          }())))),
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 30.0),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: (() {
                            if (state == Estados.Resultados) {
                              return textoAux(textoAvg, "", 30,
                                  Alignment.center, Colors.white);
                            } else {
                              return Text("");
                            }
                          }())))),
            ],
          )),
    );
  }

//Layout del Jugador 2
  Material jugador2(Estados state) {
    return Material(
      color: colorPantalla,
      child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 30, top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: comienzo(state, texto1, resultTimeText1),
              ),
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: (() {
                            if (state == Estados.Resultados) {
                              return textoAux(textoIntento1, "", 30,
                                  Alignment.center, Colors.white);
                            } else {
                              return Text("");
                            }
                          }())))),
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 30.0),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: (() {
                            if (state == Estados.Resultados) {
                              return textoAux(textoAvg1, "", 30,
                                  Alignment.center, Colors.white);
                            } else {
                              return Text("");
                            }
                          }())))),
            ],
          )),
    );
  }

  //Gestiona el texto de cominezo y de continuar si es modo mejor de 3/5
  Widget comienzo(Estados state, String text, String resultTime) {
    if (state != Estados.Comienzo) {
      return Container(
          child: (() {
        if (state == Estados.Resultados) {
          return textoAux(
              text + "\n", resultTime, 25, Alignment.center, Colors.white);
        } else {
          return textoAux(text, "", 30, Alignment.center, Colors.white);
        }
      }()));
    } else {
      return Container(
          child: Row(children: <Widget>[
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/arrow.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/arrow.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        (() {
          if (state == Estados.Resultados) {
            return Expanded(
                child: textoAux(text + "\n", resultTime, 30, Alignment.center,
                    Colors.white));
          } else {
            return Expanded(
                child: textoAux(text, "", 30, Alignment.center, Colors.white));
          }
        }()),
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/arrow.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/arrow.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ]));
    }
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
        //Caso de que sea pantalla de resultados, coloco en otra posicion el resultado
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
              maxLines: 2,
            ),
            AutoSizeText(
              texto,
              style: TextStyle(
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
      //Muesto la palabra verde en verde
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

  //Devuelve la media para el modo Mejor de 3 y 5 para jugador 1
  String getAverageText(TiposModos tipo, int numIntento) {
    String averageFinalText = '';
    double average = 0;

    if (tipo == TiposModos.Mejorde3 && numIntento == 3) {
      var sum = arrayIntentos.reduce((a, b) => a + b);
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

  //Devuelve la media para el modo Mejor de 3 y 5 para jugador 2
  String getAverageText1(TiposModos tipo, int numIntento) {
    String averageFinalText = '';
    double average = 0;

    if (tipo == TiposModos.Mejorde3 && numIntento == 3) {
      var sum = arrayIntentos1.reduce((a, b) => a + b);
      average = sum / 3;
    } else if (tipo == TiposModos.Mejorde5 && numIntento == 5) {
      var sum = arrayIntentos1.reduce((a, b) => a + b);
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
