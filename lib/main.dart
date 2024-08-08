// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'test', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Text("Бурда"),
      ),
    );
  }
}
