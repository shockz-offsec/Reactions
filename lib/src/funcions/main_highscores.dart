/*
 * Autor: shockz-offsec
 */

import 'dart:convert';
import 'package:reactions/src/models/highscore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reactions/src/models/tipos_modos.dart';

class MainHighscores {
  BehaviorSubject<List<Highscore>> _highscore$;
  BehaviorSubject<List<Highscore>> get highscore$ => _highscore$;

  MainHighscores() {
    _highscore$ = BehaviorSubject<List<Highscore>>.seeded(
      [
        Highscore(tipo: TiposModos.Test, time: 0),
        Highscore(tipo: TiposModos.Mejorde3, time: 0),
        Highscore(tipo: TiposModos.Mejorde5, time: 0)
      ],
    );
    retrieveHighscore();
  }

//Se encarga de comprobar que si el highscore dado ha superado al anterior mejor highscore, si es asi se sobreescribira
  Future checkHighscore(Highscore highscore) async {
    double oldTime = _highscore$.value
        .firstWhere((test) => test.tipo == highscore.tipo, orElse: () => null)
        .time;
    double newTime = highscore.time;

    if (oldTime > newTime || oldTime <= 0) {
      var blocList = _highscore$.value;
      blocList.removeWhere((temp) => temp.getTipo == highscore.getTipo);
      SharedPreferences sharedUser = await SharedPreferences.getInstance();
      Map<String, dynamic> tempMap = highscore.toJson();
      String newHighscoreJson = jsonEncode(tempMap);
      List<String> highscoreJsonList = [];

      if (sharedUser.getStringList('highscores') == null) {
        highscoreJsonList.add(newHighscoreJson);
        for (int i = 0; i < 2; i++) {
          String unchangedHighscoreJson = jsonEncode(blocList[i].toJson());
          highscoreJsonList.add(unchangedHighscoreJson);
        }
      } else {
        List<String> prefBeforeDecodeList =
            sharedUser.getStringList('highscores');
        List<Highscore> prefList = [];
        for (String jsonHighscore in prefBeforeDecodeList) {
          Map userMap = jsonDecode(jsonHighscore);
          Highscore tempHighscore = Highscore.fromJson(userMap);
          if (tempHighscore.tipo != highscore.tipo) {
            prefList.add(tempHighscore);
          }
        }
        for (int i = 0; i < 2; i++) {
          String unchangedHighscoreJson = jsonEncode(prefList[i].toJson());
          highscoreJsonList.add(unchangedHighscoreJson);
        }
        highscoreJsonList.add(newHighscoreJson);
      }
      sharedUser.setStringList('highscores', highscoreJsonList);
      blocList.add(highscore);
      _highscore$.add(blocList);
    }
  }

  //Se encarga de devolver los highscores de cada modo para mostrarlos en la clase Estadisticas
  Future retrieveHighscore() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> jsonList = sharedUser.getStringList('highscores');
    List<Highscore> prefList = [];
    if (jsonList == null) {
      return;
    } else {
      for (String jsonHighscore in jsonList) {
        Map userMap = jsonDecode(jsonHighscore);
        Highscore tempHighscore = Highscore.fromJson(userMap);
        prefList.add(tempHighscore);
      }
      _highscore$.add(prefList);
    }
  }
}
