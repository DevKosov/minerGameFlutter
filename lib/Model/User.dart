import 'DifficultyLevel.dart';

class User{
  final String username;
  final int score;
  final int nbTimesPlayed;
  final Difficulty difficulty;

  User(this.username, this.score, this.nbTimesPlayed, this.difficulty);
}