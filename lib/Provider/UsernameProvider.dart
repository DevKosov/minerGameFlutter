import 'package:riverpod/riverpod.dart';
import 'package:tp02/Model/DifficultyLevel.dart';

import '../Model/modele.dart';

final usernameProvider = StateNotifierProvider<UsernameNotifier, String>((ref) => UsernameNotifier());

class UsernameNotifier extends StateNotifier<String> {
  UsernameNotifier() : super("");
  void changeUsername(String name) {
    state = name;
  }
}