// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'src/wigdets/list_widget.dart';


void main() => runApp(App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'test',
        theme: ThemeData(fontFamily: 'Nunito'),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
      return MainWidget();
  }
}
