import 'package:riverpod/riverpod.dart';
import '../Model/DifficultyLevel.dart';

final difficultyProvider = StateNotifierProvider<DifficultyNotifier, Difficulty>((ref) => DifficultyNotifier());

class DifficultyNotifier extends StateNotifier<Difficulty> {
  DifficultyNotifier() : super(Difficulty.easy);

  void changeDifficulty(Difficulty difficulty) {
    state = difficulty;
  }

  Difficulty getDifficulty(){
    return state;
  }
}