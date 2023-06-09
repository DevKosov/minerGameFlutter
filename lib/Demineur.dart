

import 'package:flutter/material.dart';
import 'package:tp02/Accueil.dart';
import 'package:tp02/GrilleDemineur.dart';
import 'package:tp02/Resultat.dart';

import 'modele.dart';

class Demineur extends StatefulWidget{

  const Demineur({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DemineurState();
  }

}
// Screen state
enum ScreenState {accueil, grille, resultat}

class _DemineurState extends State<Demineur> {

  ScreenState screenState = ScreenState.accueil;
  Stopwatch stopwatch = Stopwatch();
  late Grille grille ;

  //choisir difficulty
  void choisirDifficulte(int taille, int nbMines) {
    setState(() {
      screenState = ScreenState.grille;
      grille = Grille(taille, nbMines);
      stopwatch.start();
    });
  }

  // finir la partie
  void showResults() {
    setState(() {
      stopwatch.stop();
      screenState = ScreenState.resultat;
    });
  }
  //
  // //restart
  void toAccueil() {
    setState(() {
      screenState = ScreenState.accueil; // on va afficher QuestionScreen
      stopwatch.reset();
    });
  }

  // Retourne le widget à afficher selon l'état (valeur de screenState)
  Widget chooseScreenWidget() {
    switch (screenState) {
      case ScreenState.accueil:
        {
          return Accueil(choisirDifficulte);
        }
      case ScreenState.grille:
        {
          return GrilleDemineur(
            grille: grille,
            onFinishGame: showResults,
          );
        }
      case ScreenState.resultat:
        {
          return Resultat(
            toAccueil : toAccueil,
            stopwatch : stopwatch,
            grille : grille,
          );
        }
    }
  }


  // Construction de l'UI du Widget
  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(139, 78, 13, 151),
                Color.fromARGB(81, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: chooseScreenWidget(),
        ),
      ),
    );
  }
}