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
      _grille = Grille(_difficultyLevel.taille, _difficultyLevel.nbMines);
      _stopwatch.start();
    });
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) => MinerGrid(
          grille: _grille,
          onFinishGame: showResults,
        ),
      ),
    );
  }

  // finir la partie
  void showResults() {
    setState(() {
      _stopwatch.stop();
    });
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) => Results(
          toAccueil : toAccueil,
          stopwatch : _stopwatch,
          username : _username ?? "",
          grille : _grille,
        ),
      ),
    );
  }
  //
  // //restart
  void toAccueil() {
    setState(() {
      _stopwatch.reset();
    });
    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
  }

  // Construction de l'UI du Widget
  @override
  Widget build(BuildContext context) {
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
          child: Home(choisirDifficulte, play, difficultyLevels, _difficultyLevel, _username ?? ""),
        ),
      ),
    );
  }
}