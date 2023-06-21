import 'package:flutter/material.dart';
import 'package:tp02/View/Home.dart';

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
          child: Home(),
        ),
      ),
    );
  }
}