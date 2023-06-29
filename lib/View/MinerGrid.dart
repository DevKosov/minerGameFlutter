import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tp02/Model/DifficultyLevel.dart';
import 'package:tp02/Model/modele.dart' as modele;
import 'package:tp02/Provider/DifficultyProvider.dart';
import '../Model/modele.dart';
import '../Provider/UsersProvider.dart';
import 'PotatoColorScheme.dart';
import 'Results.dart';

class MinerGrid extends ConsumerStatefulWidget {
  final String username;

  const MinerGrid({
    super.key,
    required this.username,
  });

  void onFinishGame(
      BuildContext context, WidgetRef ref, int score, Duration time) {
    ref
        .read(usersProvider.notifier)
        .addUser(username, score, ref.read(difficultyProvider));

    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) => Results(score: score, time: time),
      ),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MinerGrid();
  }
}

// Riverpod : on hérite ici de ConsumerState
class _MinerGrid extends ConsumerState<MinerGrid> {
  late Grille _grille;
  final Stopwatch _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    _grille = Grille(ref.read(difficultyProvider).difficultyLevel.taille,
        ref.read(difficultyProvider).difficultyLevel.nbMines); // Initialization
    _stopwatch.start();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: potatoColors,
            elevatedButtonTheme: minerButtonTheme),
        home: Scaffold(
            appBar: AppBar(
              title: const Center(child: Text("Play")),
              backgroundColor: const Color.fromARGB(255, 251, 246, 239),
            ),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int x = 0; x < _grille.taille; x++) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int y = 0; y < _grille.taille; y++) ...[
                          Container(
                            width: 50.0, // Set the desired width
                            height: 50.0, // Set the desired height
                            margin: const EdgeInsets.all(0.5),
                            child: ElevatedButton(
                              onPressed: () {
                                if (!_grille.isFinie()) {
                                  setState(() {
                                    jouerCoup(
                                        context, x, y, modele.Action.decouvrir);
                                  });
                                  isFinished();
                                }
                              },
                              onLongPress: () {
                                if (!_grille.isFinie()) {
                                  setState(() {
                                    jouerCoup(
                                        context, x, y, modele.Action.marquer);
                                  });
                                  isFinished();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: caseToColor(
                                    _grille.getCase(modele.Coordonnees(x, y))),
                                // Background color
                                padding: const EdgeInsets.all(10.0),
                              ),
                              child: Text(caseToText(
                                  _grille.getCase(modele.Coordonnees(x, y)),
                                  _grille.isFinie())),
                            ),
                          )
                        ],
                      ],
                    )
                  ],
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text("Chose a case to mine!!!"),
                  )
                ])));
  }

  String caseToText(modele.Case laCase, bool isFini) {
    if (!isFini) {
      if (laCase.decouverte) {
        return laCase.nbMinesAutour.toString();
      } else if (laCase.marquee) {
        return "🚩";
      } else {
        return "#";
      }
    } else {
      return laCase.minee
          ? "💣"
          : laCase.nbMinesAutour == 0
              ? ""
              : laCase.nbMinesAutour.toString();
    }
  }

  Color caseToColor(modele.Case laCase) {
    if (laCase.decouverte) {
      return Colors.grey;
    } else if (laCase.marquee) {
      return Colors.limeAccent;
    } else {
      return Colors.blueAccent;
    }
  }

  void isFinished() {
    if (_grille.isGagnee()) {
      _stopwatch.stop();
      widget.onFinishGame(context, ref,
          calculateScore(_stopwatch.elapsedMilliseconds), _stopwatch.elapsed);
      _stopwatch.reset();
    } else if (_grille.isPerdue()) {
      _stopwatch.stop();
      widget.onFinishGame(context, ref, 0, _stopwatch.elapsed);
      _stopwatch.reset();
    }
  }

  void jouerCoup(context, x, y, action) {
    Coup coup = Coup(x, y, action);
    _grille.mettreAJour(coup);
  }

  int calculateScore(timeInMilliseconds) {
    if (timeInMilliseconds <= 10000) {
      return 10000;
    } else {
      return ((1000 / timeInMilliseconds) * 10000).toInt();
    }
  }
}
