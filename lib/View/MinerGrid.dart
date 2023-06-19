
import 'package:flutter/material.dart';
import 'package:tp02/Model/modele.dart' as modele;

import '../Model/modele.dart';

class MinerGrid extends StatefulWidget {
  Grille grille;

  final void Function() onFinishGame;

  MinerGrid({
    super.key,
    required this.grille,
    required this.onFinishGame,
  });
  @override
  State<StatefulWidget> createState() => _GrilleDemineur();
}

class _GrilleDemineur extends State<MinerGrid> {
  late modele.Grille _grille;
  @override
  void initState() {
    _grille = widget.grille;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Demineur',
        home: Scaffold(
          appBar: AppBar(title: Text('Demineur tp2')),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int x = 0; x < _grille.taille ; x++) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int y = 0; y < _grille.taille ; y++) ...[
                      Container(
                        width: 50.0, // Set the desired width
                        height: 50.0, // Set the desired height
                        margin: const EdgeInsets.all(0.5),
                       child:
                       ElevatedButton(
                         onPressed: (){
                           setState(() {
                             if (!_grille.isFinie()) {
                               jouerCoup(x, y, modele.Action.decouvrir);
                             }
                           });
                         },
                         onLongPress: () {
                           setState(() {
                             if (!_grille.isFinie()) {
                               jouerCoup(x, y,modele.Action.marquer);
                             }
                           });
                         },
                         style: ElevatedButton.styleFrom(
                           backgroundColor: caseToColor(_grille.getCase(modele.Coordonnees(x,y))), // Background color
                           padding: const EdgeInsets.all(10.0),
                         ),
                         child: Text(
                             caseToText(_grille.getCase(modele.Coordonnees(x,y)),_grille.isFinie())
                         ),
                       ),
                      )
                    ],
                  ],
                )
              ],
              Container(
                margin: const EdgeInsets.only(top:20),
              child:
                Text(
                    messageEtat(_grille)
                ),
              )
            ]
          ),
        ));
  }
  String caseToText(modele.Case laCase, bool isFini) {
    if (!isFini){
      if (laCase.decouverte){
        return laCase.nbMinesAutour.toString();
      }
      else if (laCase.marquee){
        return "🚩";
      }else{
        return "#";
      }
    }else{
      return laCase.minee ? "💣" : laCase.nbMinesAutour == 0 ? "" : laCase.nbMinesAutour.toString();
    }
  }
  Color caseToColor(modele.Case laCase) {
    if (laCase.decouverte){
      return Colors.grey;
    }
    else if (laCase.marquee){
      return Colors.limeAccent;
    }else{
      return Colors.blueAccent;
    }
  }
  String messageEtat(modele.Grille grille) {
    if (_grille.isGagnee() || _grille.isPerdue()){
      return "GZZZZZZ you won!";
    }else{
      return "Chose a case to mine!!!";
    }
  }
  void jouerCoup(int x, int y,modele.Action action){
    modele.Coup coup = modele.Coup(x,y,action);
    _grille.mettreAJour(coup);
    if (_grille.isGagnee() || _grille.isPerdue()){
      widget.onFinishGame();
    }
  }
}
