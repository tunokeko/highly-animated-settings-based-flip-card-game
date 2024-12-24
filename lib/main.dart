import 'package:animated_flip_card/pages/menu_page.dart';
import 'package:animated_flip_card/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MenuPage(),
      ),
    );
  }
}
