
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tp02/Model/modele.dart' as modele;
import 'package:tp02/Provider/GrilleProvider.dart';

import '../Model/modele.dart';
import 'Results.dart';

class MinerGrid extends ConsumerWidget {

  MinerGrid({
    super.key,
  });

  void onFinishGame(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) => const Results(),
      ),
    );
  }

  late Grille _grille;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    _grille = ref.watch(grilleProvider);

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Play"),
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
                            child:
                            ElevatedButton(
                              onPressed: () {
                                if (!_grille.isFinie()) {
                                  ref.read(grilleProvider.notifier).jouerCoup(x,y,modele.Action.marquer);
                                  checkEnding(context);
                                }
                              },
                              onLongPress: () {
                                if (!_grille.isFinie()) {
                                  ref.read(grilleProvider.notifier).jouerCoup(x,y,modele.Action.marquer);
                                  checkEnding(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: caseToColor(
                                    _grille.getCase(modele.Coordonnees(x, y))),
                                // Background color
                                padding: const EdgeInsets.all(10.0),
                              ),
                              child: Text(
                                  caseToText(
                                      _grille.getCase(modele.Coordonnees(x, y)),
                                      _grille.isFinie())
                              ),
                            ),
                          )
                        ],
                      ],
                    )
                  ],
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child:
                    Text("Chose a case to mine!!!"),
                  )
                ]
            )
        )
    );
  }

  String caseToText(modele.Case laCase, bool isFini) {
    if (!isFini) {
      if (laCase.decouverte) {
        return laCase.nbMinesAutour.toString();
      }
      else if (laCase.marquee) {
        return "🚩";
      } else {
        return "#";
      }
    } else {
      return laCase.minee ? "💣" : laCase.nbMinesAutour == 0 ? "" : laCase
          .nbMinesAutour.toString();
    }
  }

  Color caseToColor(modele.Case laCase) {
    if (laCase.decouverte) {
      return Colors.grey;
    }
    else if (laCase.marquee) {
      return Colors.limeAccent;
    }
    else {
      return Colors.blueAccent;
    }
  }

  void checkEnding(BuildContext context) {
    if (_grille.isGagnee() || _grille.isPerdue()) {
      onFinishGame(context);
    }
  }
}