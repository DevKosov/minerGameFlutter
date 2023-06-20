import 'package:flutter/material.dart';
import 'package:tp02/Controller/Miner.dart';

void main() {
  runApp(const MinerApp());
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

