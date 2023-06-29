class DifficultyLevel {
  final String level;
  final int taille;
  final int nbMines;

  DifficultyLevel({
    required this.level,
    required this.taille,
    required this.nbMines,
  });
}

enum Difficulty{
  easy,
  intermediate,
  expert
}

extension DifficultyExtension on Difficulty {
  DifficultyLevel get difficultyLevel {
    switch (this) {
      case Difficulty.easy:
        return DifficultyLevel(level: "Easy", taille: 5, nbMines: 1);
      case Difficulty.intermediate:
        return DifficultyLevel(level: "Intermediate", taille: 7, nbMines: 10);
      case Difficulty.expert:
        return DifficultyLevel(level: "Expert", taille: 10, nbMines: 15);
      default:
        throw Exception('Invalid difficulty level');
    }
  }
}

