import 'package:animated_flip_card/pages/game_page.dart';
import 'package:animated_flip_card/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => GamePage()));
            },
            child: Text("Start")),
        SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final value in Difficulty.values)
              generateButton(value, context)
          ],
        )
      ],
    ));
  }

  Widget generateButton(Difficulty difficulty, BuildContext context) {
    final settingsState = Provider.of<SettingsProvider>(context);

    return GestureDetector(
      onTap: () {
        settingsState.changeDifficulty(difficulty);
      },
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: settingsState.difficulty == difficulty
                  ? Colors.blue
                  : Colors.black),
          child: Text(
            difficulty.text,
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
