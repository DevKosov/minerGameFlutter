import 'package:riverpod/riverpod.dart';
import 'package:tp02/Model/DifficultyLevel.dart';

import '../Model/modele.dart';

final stopWatchProvider = StateNotifierProvider<StopWatchNotifier, Stopwatch>((ref) => StopWatchNotifier());

class StopWatchNotifier extends StateNotifier<Stopwatch> {
  StopWatchNotifier() : super(Stopwatch());
  void startStopWatch(String name) {
    state.start();
  }
  void stopStopWatch(String name) {
    state.stop();
  }
  void resetStopWatch(String name) {
    state.reset();
  }
}