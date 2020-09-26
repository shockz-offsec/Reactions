/*
 * Autor: jmlgomez73
 */

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:reactions/src/models/tipos_modos.dart';
import 'package:reactions/src/ui/juego/dos_jugadores.dart';
import 'package:reactions/src/ui/juego/un_jugador.dart';
import 'package:flutter/material.dart';
import 'package:reactions/src/ui/menus/principal.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:reactions/src/ui/estadisticas/estatidisticas.dart';
import 'package:reactions/src/ui/informacion.dart';

class MenuSecundario extends StatefulWidget {
  final TiposModos tipo;
  MenuSecundario(this.tipo, {Key key}) : super(key: key);
  @override
  _MenuSecundarioState createState() => _MenuSecundarioState();
}

class _MenuSecundarioState extends State<MenuSecundario> {
  final PageController viewController =
      PageController(viewportFraction: 0.8, initialPage: 0);

  //la pagina 3 es la del menu principal
  int currentPage = 3;
  bool selec = false;
  GlobalKey bottomNavigationKey = GlobalKey();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: IndexedStack(
        index: currentPage,
        children: [
          Estadisticas(),
          MenuPrincipal(),
          Informacion(),
          secundario(context, widget.tipo),
        ],
      ),
      bottomNavigationBar: FancyBottomNavigation(
          key: bottomNavigationKey,
          initialSelection: 1,
          inactiveIconColor: Colors.black,
          textColor: Colors.black,
          tabs: [
            TabData(
              iconData: Icons.timeline,
              title: "Estadísticas",
            ),
            TabData(
                iconData: Icons.flash_on,
                title: "Inicio",
                //Uso esto y la key para poder refresar al pulsar en inicio para poder volver al inicio
                onclick: () {
                  final FancyBottomNavigationState fState =
                      bottomNavigationKey.currentState;
                  fState.setPage(1);
                }),
            TabData(
              iconData: Icons.info_outline,
              title: "Ajustes",
            ),
          ],
          onTabChangedListener: (int position) async {
            {
              setState(() {
                currentPage = position;
                selec = true;
              });
            }
          }),
    );
  }
}

//Todo el builder del menu secundario
Widget secundario(BuildContext context, TiposModos tipo) {
  return Container(
    margin: const EdgeInsets.only(top: 10.0),
    decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage("assets/fondo_reactions.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: ButtonTheme(
                      height: 60,
                      child: RaisedButton(
                        elevation: 12,
                        splashColor: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).push(SwipeablePageRoute(
                            builder: (BuildContext context) => UnJugador(tipo),
                          ));
                        },
                        child: Text(
                          '1 Jugador',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.yellow,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        color: Colors.black.withOpacity(0.75),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: ButtonTheme(
                      height: 60,
                      child: RaisedButton(
                        elevation: 12,
                        splashColor: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).push(SwipeablePageRoute(
                            builder: (BuildContext context) =>
                                DosJugadores(tipo),
                          ));
                        },
                        child: Text(
                          '2 Jugadores',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.yellow,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        color: Colors.black.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  ),
                ),
              ]),
        )),
  );
}
