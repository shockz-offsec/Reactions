/*
 * Autor: jmlgomez73
 */

import 'package:reactions/src/models/tipos_modos.dart';
import 'package:flutter/material.dart';
import 'package:reactions/src/ui/menus/secundario.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class MenuPrincipal extends StatefulWidget {
  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  final PageController viewController =
      PageController(viewportFraction: 0.8, initialPage: 0);

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
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
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: ButtonTheme(
                          child: RaisedButton(
                            elevation: 12,
                            splashColor: Colors.blue,
                            onPressed: () {
                              Navigator.of(context).push(SwipeablePageRoute(
                                builder: (BuildContext context) =>
                                    MenuSecundario(TiposModos.Test),
                              ));
                            },
                            child: Text(
                              'Test',
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
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: ButtonTheme(
                          child: RaisedButton(
                            elevation: 12,
                            splashColor: Colors.blue,
                            onPressed: () {
                              Navigator.of(context).push(SwipeablePageRoute(
                                builder: (BuildContext context) =>
                                    MenuSecundario(TiposModos.Mejorde3),
                              ));
                            },
                            child: Text(
                              'Mejor de 3',
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: ButtonTheme(
                          child: RaisedButton(
                            elevation: 12,
                            splashColor: Colors.blue,
                            onPressed: () {
                              Navigator.of(context).push(SwipeablePageRoute(
                                builder: (BuildContext context) =>
                                    MenuSecundario(TiposModos.Mejorde5),
                              ));
                            },
                            child: Text(
                              'Mejor de 5',
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
      ),
    );
  }

  void dispose() {
    super.dispose();
    viewController.dispose();
  }
}
