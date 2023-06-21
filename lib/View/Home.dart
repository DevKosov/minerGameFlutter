import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tp02/Model/DifficultyLevel.dart';
import 'package:tp02/Provider/DifficultyProvider.dart';
import 'package:tp02/Provider/GrilleProvider.dart';
import 'package:tp02/Provider/UsernameProvider.dart';

import 'MinerGrid.dart';


class Home extends ConsumerWidget {
  // Constructeur
  Home({
    super.key
  });

  void play(BuildContext context, WidgetRef ref){

    ref.read(grilleProvider.notifier).initGrille(ref.read(difficultyProvider).difficultyLevel);

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) => MinerGrid(),
      ),
    );
  }

  Difficulty? _selectedDifficulty ;
  late String _username;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    _username = ref.watch(usernameProvider);
    _selectedDifficulty = ref.watch(difficultyProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Demineur")
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Miner Game',
                style: TextStyle(
                  color: Color.fromARGB(255, 237, 223, 252),
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _textController,
                keyboardType: TextInputType.text,
                maxLength: 40,
                decoration: const InputDecoration(
                  suffixText: '',
                  label: Text('Username'),
                ),
                onChanged: (value) {
                  ref.read(usernameProvider.notifier).changeUsername(value);
                },
              ),
              DropdownButton(
                value: _selectedDifficulty,

                items: Difficulty.values.map((difficulty) =>
                    DropdownMenuItem<Difficulty>(
                      value: difficulty,
                      child: Text(
                        difficulty.difficultyLevel.level.toString().toUpperCase(),
                      ),
                    ),
                ).toList(),
                onChanged: (value) {
                  if (value == null) {
                    return ;
                  }
                  ref.read(difficultyProvider.notifier).changeDifficulty(value);
                },
              ),
              ElevatedButton(
                  onPressed: _username.isEmpty ? null : () {
                    play(context,ref);
                  },
                  child: const Text("Play")
              ),
            ],
          ),
        ),
      )
    );
  }
}
