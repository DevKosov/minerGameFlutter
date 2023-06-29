import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tp02/Controller/Miner.dart';

void main() async {
  runApp(const ProviderScope(child: MinerApp()));
}

class MinerApp extends StatelessWidget {
  const MinerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Miner()
    );
  }
}

