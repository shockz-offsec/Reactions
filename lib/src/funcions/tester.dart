/*
 * Autor: jmlgomez73
 */

import 'package:rxdart/rxdart.dart';
import 'package:reactions/src/models/estados.dart';

//Esta clase se encarga de contener los diversos estados por los que pasa la app durante el juego //Stopwatch y paso de pantallas , para uso mas óptimo.
class Tester {
  Stopwatch _stopwatch = Stopwatch();

  BehaviorSubject<Estados> _estados$;
  BehaviorSubject<Estados> get estados$ => _estados$;

  BehaviorSubject<double> _resultTime$;
  BehaviorSubject<double> get resultTime$ => _resultTime$;

  Tester() {
    _estados$ = BehaviorSubject<Estados>.seeded(Estados.Comienzo);
    _resultTime$ = BehaviorSubject<double>.seeded(0.0);
  }

  void nextScreen(Estados currentState) {
    switch (currentState) {
      case Estados.Comienzo:
        _estados$.add(Estados.Espera);
        break;
      case Estados.Espera:
        _estados$.add(Estados.Toque);
        _stopwatch.start();
        break;
      case Estados.Toque:
        _stopwatch.stop();
        _resultTime$.add(_stopwatch.elapsedMilliseconds.toDouble());
        _stopwatch.reset();
        _estados$.add(Estados.Resultados);
        break;

      case Estados.Resultados:
        _estados$.add(Estados.Comienzo);
        break;

      case Estados.ErrorToque:
        _estados$.add(Estados.ErrorPantalla);
        break;
      case Estados.ErrorPantalla:
        _estados$.add(Estados.Comienzo);
        break;
      default:
        _estados$.add(Estados.Comienzo);
    }
  }

  void dispose() {
    _estados$.close();
    _resultTime$.close();
  }
}
