import 'package:animated_flip_card/components/card_table.dart';
import 'package:animated_flip_card/game_state.dart';
import 'package:animated_flip_card/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Difficulty difficulty = context.read<SettingsProvider>().difficulty;
    return ChangeNotifierProvider(
      create: (context) => GameState(difficulty: difficulty),
      child: Builder(builder: (context) => buildGame(context)),
    );
  }

  Widget buildGame(BuildContext context) {
    return Scaffold(
      key: Provider.of<GameState>(context)
          .key, // I change it back to initial state by giving a different key and make Flutter completely re-render
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardTable(),
                SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<GameState>().restart();
                    },
                    child: Text("Restart"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
