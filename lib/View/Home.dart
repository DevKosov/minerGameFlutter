import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tp02/Model/DifficultyLevel.dart';
import 'package:tp02/Provider/DifficultyProvider.dart';
import 'package:tp02/Provider/UsernameProvider.dart';

import '../Model/User.dart';
import 'MinerGrid.dart';


class Home extends ConsumerStatefulWidget {
  // Constructeur
  Home({
    super.key
  });

  void play(BuildContext context, WidgetRef ref, String username) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) =>
            MinerGrid(
              username : username
            ),
      ),
    );
  }
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _Home();
  }

}
class _Home extends ConsumerState<Home> {

  late String _username;
  final _textController = TextEditingController();
  late Difficulty _selectedDifficulty;
  late List<User> _top3;

  @override
  void initState() {
    super.initState();
    _username = "";
  }

  @override
  Widget build(BuildContext context) {

    _selectedDifficulty = ref.watch(difficultyProvider);
    _top3 = ref.watch(usersProviderTop3(_selectedDifficulty));

    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Demineur")),
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
              // ListView(
              //   children: [
              //     for (var user in _top3) Card(child:ListTile(title:Text("${user.username} : ${user.score}")))
              //   ],
              // ),
              Column(
                  children: [
                    for (var user in _top3) Text("${user.username} : ${user.score}")
                  ],
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
                  setState(() {
                    _username = value;
                  });
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
                    widget.play(context,ref,_username);
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
