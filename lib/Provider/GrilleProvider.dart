

import 'package:riverpod/riverpod.dart';
import 'package:tp02/Model/DifficultyLevel.dart';

import '../Model/modele.dart';

final grilleProvider = StateNotifierProvider<GrilleNotifier, Grille>((ref) => GrilleNotifier());

class GrilleNotifier extends StateNotifier<Grille> {
  GrilleNotifier() : super(Grille(4,4));

  void initGrille(DifficultyLevel difficultyLevel) {
    state = Grille(difficultyLevel.taille, difficultyLevel.nbMines);
  }

  void jouerCoup(x,y,action){
    Coup coup = Coup(x, y, action);
    state.mettreAJour(coup);
    state = state;
  }

}