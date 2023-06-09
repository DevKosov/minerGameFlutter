import 'package:flutter/material.dart';

Map<String, Map<String, dynamic>> difficultyLevels = {
  "Easy": {
    "taille": 5,
    "nbMines": 4,
  },
  "Intermediate": {
    "taille": 7,
    "nbMines": 10,
  },
  "Extreme": {
    "taille": 10,
    "nbMines": 15,
  },
};


class Accueil extends StatelessWidget {

  final void Function(int taille, int nbMines) choisirDifficulte;

  // Constructeur
  const Accueil(this.choisirDifficulte, {super.key});

  // Construction de l'UI du Widget StartScreen
  @override
  Widget build(context) {
    List<Widget> buttons = [];
    difficultyLevels.forEach((difficultyLabel, difficultyMap) {
      buttons.add(
        ElevatedButton(
          onPressed: () {
            choisirDifficulte(difficultyMap['taille'], difficultyMap['nbMines']);
          },
          child: Text(difficultyLabel),
        ),
      );
    });

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Miner Game',
            style: TextStyle(
              color: Color.fromARGB(255, 237, 223, 252),
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 30),
          ...buttons,
        ],
      ),
    );
  }
}
