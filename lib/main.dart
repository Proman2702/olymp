import 'package:flutter/material.dart';
import 'package:my_app/features/home/page.dart';
import 'package:my_app/features/settings/page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      "/": (context) => HomePage(),
      "/settings": (context) => SettingsPage()
    }, theme: ThemeData(fontFamily: 'Nunito'));
  }
}
