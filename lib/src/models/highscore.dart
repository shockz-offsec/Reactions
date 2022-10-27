/*
 * Autor: shockz-offsec
 */

import 'package:reactions/src/models/tipos_modos.dart';

class Highscore {
  TiposModos tipo;
  double time;

  Highscore({
    this.tipo,
    this.time,
  });

  String get getTipoString =>
      tipo.toString().substring(11); //substring(11) para facilitar if en toJson

  //Para estadisticas transformo el resultado en ms o seg
  String get getTimeCorrectly {
    String timeResultText = '';
    if (time > 1000) {
      timeResultText = (time / 1000).toStringAsFixed(3) + " seg";
    } else {
      timeResultText = (time.toInt()).toString() + " ms";
    }
    return timeResultText;
  }

  TiposModos get getTipo => tipo;
  double get getTime => time;

  Map<String, dynamic> toJson() {
    return {
      "tipo": this.tipo.toString().substring(11),
      "time": this.time,
    };
  }

  factory Highscore.fromJson(Map<String, dynamic> parsedJson) {
    String tipoString = parsedJson['tipo'];
    TiposModos tempTipo;

    if (tipoString == "Test") {
      tempTipo = TiposModos.Test;
    } else if (tipoString == "Mejorde3") {
      tempTipo = TiposModos.Mejorde3;
    } else {
      tempTipo = TiposModos.Mejorde5;
    }

    return Highscore(
      tipo: tempTipo,
      time: parsedJson['time'],
    );
  }
}
