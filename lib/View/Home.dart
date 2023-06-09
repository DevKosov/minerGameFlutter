import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tp02/Model/DifficultyLevel.dart';
import 'package:tp02/Provider/DifficultyProvider.dart';
import 'package:tp02/Provider/UsersProvider.dart';

import '../Model/User.dart';
import 'MinerGrid.dart';
import 'PotatoColorScheme.dart';

class Home extends ConsumerStatefulWidget {
  // Constructeur
  Home({super.key});

  void play(BuildContext context, WidgetRef ref, String username) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) => MinerGrid(username: username),
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
        theme: ThemeData(
          elevatedButtonTheme: elevatedButtonTheme,
          useMaterial3: true,
          colorScheme: potatoColors,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Center(
                  child: Text(
                "Miner Game",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              )),
              backgroundColor: const Color.fromARGB(255, 251, 246, 239),
            ),
            body: Center(
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 768),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Top 3 players in ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: _selectedDifficulty
                                          .difficultyLevel.level,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  const TextSpan(
                                      text: ' mode',
                                      style: TextStyle(fontSize: 18)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 240, // provide a suitable height
                              child: ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  for (var user in _top3)
                                    Card(
                                        child: ListTile(
                                            title: Text(user.username),
                                            subtitle: Text(
                                                "${user.nbTimesPlayed} ${user.nbTimesPlayed > 1 ? "times" : "time"} played!"),
                                            trailing: Text("${user.score}")))
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            TextField(
                              controller: _textController,
                              keyboardType: TextInputType.text,
                              maxLength: 20,
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
                              items: Difficulty.values
                                  .map(
                                    (difficulty) =>
                                        DropdownMenuItem<Difficulty>(
                                      value: difficulty,
                                      child: Text(
                                        difficulty.difficultyLevel.level
                                            .toString()
                                            .toUpperCase(),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) {
                                  return;
                                }
                                ref
                                    .read(difficultyProvider.notifier)
                                    .changeDifficulty(value);
                              },
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                                onPressed: _username.isEmpty
                                    ? null
                                    : () {
                                        widget.play(context, ref, _username);
                                      },
                                child: const Text("Play")),
                          ],
                        ),
                      ),
                    )))));
  }
}
