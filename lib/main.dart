// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(App());

class App extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Test",
            style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w800),
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: const MainWidget(),
      ),
    );
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          color: Colors.orange,
          width: 250,
          height: 50,
          child: Text(
            "привет",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          alignment: Alignment.center,
          color: Colors.orange,
          width: 100,
          height: 20,
          child: Text("бурда"),
        )
      ],
    );
  }
}
