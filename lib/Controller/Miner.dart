import 'package:flutter/material.dart';
import 'package:tp02/View/Home.dart';
import 'package:tp02/View/MinerGrid.dart';
import 'package:tp02/View/Results.dart';

import '../Model/DifficultyLevel.dart';
import '../Model/modele.dart';

class Miner extends StatefulWidget{

  const Miner({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MinerState();
  }

}
// Screen state
enum ScreenState {accueil, grille, resultat}

class _MinerState extends State<Miner> {

  ScreenState     _screenState        = ScreenState.accueil;
  final Stopwatch _stopwatch          = Stopwatch();
  DifficultyLevel _difficultyLevel    = difficultyLevels[0];
  late Grille     _grille ;
  String?         _username ;

  // Choisir difficulty
  void choisirDifficulte(DifficultyLevel difficultyLevel) {
    setState(() {
      _difficultyLevel = difficultyLevel;
    });
  }

  // Play
  void play(String username) {
    setState(() {
      _username = username;
      _screenState = ScreenState.grille;
      _grille = Grille(_difficultyLevel.taille, _difficultyLevel.nbMines);
      _stopwatch.start();
    });
  }

  // finir la partie
  void showResults() {
    setState(() {
      _stopwatch.stop();
      _screenState = ScreenState.resultat;
    });
  }
  //
  // //restart
  void toAccueil() {
    setState(() {
      _screenState = ScreenState.accueil; // on va afficher QuestionScreen
      _stopwatch.reset();
    });
  }

  // Retourne le widget à afficher selon l'état (valeur de screenState)
  Widget chooseScreenWidget() {
    switch (_screenState) {
      case ScreenState.accueil:
        {
          return Home(choisirDifficulte, play, difficultyLevels, _difficultyLevel, _username ?? "");
        }
      case ScreenState.grille:
        {
          return MinerGrid(
            grille: _grille,
            onFinishGame: showResults,
          );
        }
      case ScreenState.resultat:
        {
          return Results(
            toAccueil : toAccueil,
            stopwatch : _stopwatch,
            username : _username ?? "",
            grille : _grille,
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
                Color.fromARGB(139, 101, 144, 209),
                Color.fromARGB(81, 135, 165, 202),
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