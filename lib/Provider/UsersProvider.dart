import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/User.dart';
import '../Model/modele.dart';
import '../Model/DifficultyLevel.dart';

final usersProvider = StateNotifierProvider<UsersNotifier, List<User>>((ref) => UsersNotifier());

class UsersNotifier extends StateNotifier<List<User>> {
  UsersNotifier() : super([]) {
    loadUsers();
  }

  Future<void> loadUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final usersString = prefs.getString('users') ?? '[]';
    final usersList = (jsonDecode(usersString) as List)
        .map((userJson) => User.fromJson(userJson))
        .toList();
    state = usersList;
  }

  void addUser(String username, int score, Difficulty difficulty) async {
    bool userExists = false;

    state = state.map((oldUser) {
      if (oldUser.username == username) {
        userExists = true;
        return User(oldUser.username,
            (score > oldUser.score ? score : oldUser.score),
            oldUser.nbTimesPlayed + 1, difficulty);
      } else {
        return oldUser;
      }
    }).toList();

    if (!userExists) {
      state.add(User(username, score, 1, difficulty));
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final usersString = jsonEncode(state.map((user) => user.toJson()).toList());
    await prefs.setString('users', usersString);

  }
}


// Provider 'paramétré' pour accéder à un plat parmi les plats fournis par mealsProvider
final usersProviderTop3 = Provider.family<List<User>,Difficulty>((ref,difficulty) {
  final users = ref.watch(usersProvider);

  final usersWithGivenDifficulty = users.where((user) => user.difficulty == difficulty).toList();

  usersWithGivenDifficulty.sort((a, b) => b.score.compareTo(a.score)); // Sort in descending order of score

  return usersWithGivenDifficulty.take(3).toList();

});