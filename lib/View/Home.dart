import 'package:flutter/material.dart';
import 'package:tp02/Model/DifficultyLevel.dart';


class Home extends StatefulWidget {

  final void Function(DifficultyLevel difficultyLevel) choisirDifficulte;
  final void Function(String username) play;
  final List<DifficultyLevel> difficultyLevels;
  final DifficultyLevel difficultyLevel;
  final String username;

  // Constructeur
  const Home(this.choisirDifficulte,
      this.play,
      this.difficultyLevels,
      this.difficultyLevel,
      this.username,
      {super.key});

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  List<DifficultyLevel>? difficultyLevels ;
  DifficultyLevel? _selectedDifficulty ;
  late String _username;
  final _textController = TextEditingController();
  // Construction de l'UI du Widget StartScreen

  @override
  void initState() {
    super.initState();
    _textController.text = widget.username;
    difficultyLevels = widget.difficultyLevels;
    _username = widget.username ?? "";
  }

  @override
  Widget build(context) {
    return Center(
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
              setState(() {
                _username = value;
              });
            },
          ),
          DropdownButton(
            value: _selectedDifficulty ?? widget.difficultyLevel,
            items: difficultyLevels?.map((difficulty) =>
              DropdownMenuItem<DifficultyLevel>(
                value: difficulty,
                child: Text(
                  difficulty.level.toUpperCase(),
                ),
              ),
            ).toList(),
            onChanged: (value) {
              if (value == null) {
                return ;
              }
              setState((){
                _selectedDifficulty = value ;
              });
              widget.choisirDifficulte(value) ;
            },
          ),
          ElevatedButton(
              onPressed: _username.isEmpty ? null : () {
                widget.play(_username);
              },
              child: Text("Play")
          ),
        ],
      ),
    );
  }
}

