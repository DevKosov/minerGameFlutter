import 'package:flutter/material.dart';
import 'package:tp02/Model/modele.dart';

import 'PotatoColorScheme.dart';

class Results extends StatelessWidget {
  final int score;
  final Duration time;
  // Constructeur
  const Results({super.key, required this.score, required this.time});

  // Construction de l'UI du Widget StartScreen
  @override
  Widget build(context) {
    String gameStatus = (score == 0 ? "Game Over!" : "WINNER!!");

    return MaterialApp(
        theme: ThemeData(useMaterial3: true, colorScheme: potatoColors),
        home: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text("Results")),
            backgroundColor: const Color.fromARGB(255, 251, 246, 239),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  gameStatus,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 30),
                Text("Score of $score!"),
                Text("Time elapsed : ${_formatDuration(time)} seconds"),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {
                      toAccueil(context);
                    },
                    child: const Text("Go Back"))
              ],
            ),
          ),
        ));
  }

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    String formattedDuration = '';
    if (hours != 0) {
      formattedDuration += '${hours}h ';
    }
    if (minutes != 0 || hours != 0) {
      formattedDuration += '${minutes}m ';
    }
    formattedDuration += '${seconds}s';

    return formattedDuration.trim();
  }

  void toAccueil(context) {
    Navigator.of(context).pop();
  }
}
