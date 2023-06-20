import 'package:flutter/material.dart';
import 'package:tp02/Model/modele.dart';

class Results extends StatelessWidget {

  final void Function() toAccueil;
  final Stopwatch stopwatch;
  final String username;
  final Grille grille;
  // Constructeur
  const Results({
    super.key,
    required this.toAccueil,
    required this.stopwatch,
    required this.username,
    required this.grille,
  });

  // Construction de l'UI du Widget StartScreen
  @override
  Widget build(context) {

    String gameStatus = grille.isPerdue() ? "$username, you're so BAAAAD!" : (grille.isGagnee() ? "${username}, you've WON!!! POGU" : "");

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Results"),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                gameStatus,
                style: TextStyle(
                  color: Color.fromARGB(255, 237, 223, 252),
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 30),
              Text("You've taken ${_formatDuration(stopwatch.elapsed)}!"),
              ElevatedButton(
                  onPressed: toAccueil,
                  child: const Text("Go Back")
              )
            ],
          ),
        ),
      )
    );
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

}
