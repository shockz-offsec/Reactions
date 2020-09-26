/*
 * Author: jmlgomez73
 */

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:reactions/src/ui/estadisticas/estatidisticas.dart';
import 'package:reactions/src/ui/menus/principal.dart';
import 'package:provider/provider.dart';
import 'package:reactions/src/funcions/main_highscores.dart';
import 'package:reactions/src/ui/informacion.dart';

void main() => runApp(Reactions());

class Reactions extends StatefulWidget {
  @override
  _Reactions createState() => _Reactions();
}

class _Reactions extends State<Reactions> {
  MainHighscores mainHighscores;

  void initState() {
    mainHighscores = MainHighscores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<MainHighscores>.value(
        value: mainHighscores,
        child: MaterialApp(
          title: 'Reactions',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Asap'),
          home: Inicio(),
        ));
  }
}

//Creado para tener un bottomNavBar general
class Inicio extends StatefulWidget {
  @override
  _Inicio createState() => _Inicio();
}

class _Inicio extends State<Inicio> {
  int currentPage = 1;
  final _children = <Widget>[
    Estadisticas(),
    MenuPrincipal(),
    Informacion(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: _children,
      ),
      bottomNavigationBar: FancyBottomNavigation(
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
            ),
            TabData(
              iconData: Icons.info_outline,
              title: "Ajustes",
            ),
          ],
          onTabChangedListener: (int position) async {
            {
              setState(() {
                currentPage = position;
              });
            }
          }),
    );
  }
}
