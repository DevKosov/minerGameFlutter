import 'DifficultyLevel.dart';

class User {
  final String username;
  final int score;
  final int nbTimesPlayed;
  final Difficulty difficulty;

  User(this.username, this.score, this.nbTimesPlayed, this.difficulty);

  // Convert a User object into a Map.
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'score': score,
      'nbTimesPlayed': nbTimesPlayed,
      'difficulty': difficulty.name,
    };
  }

  // Convert a Map into a User object.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['username'] as String,
      json['score'] as int,
      json['nbTimesPlayed'] as int,
      Difficulty.values.firstWhere((dif) => dif.name == json['difficulty']),
    );
  }
}
