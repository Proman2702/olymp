// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'src/wigdets/list_widget.dart';
import 'src/wigdets/add_audio.dart';

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
        elevation: 3,
        toolbarHeight: 70,
        shadowColor: Colors.deepPurple,
        leadingWidth: 100, titleSpacing: 10,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.elliptical(200, 20), bottomRight: Radius.elliptical(200, 20)
        //     )
        // ),
        title: Container(
          padding: EdgeInsets.all(5),
            child: Text(
              "Test",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800, color: Colors.white),
            ),
          ),
        backgroundColor: Color.fromARGB(255, 161, 29, 201),
      ),
      body: Center(
        child: const MainWidget(),
      
      ),
      floatingActionButton: AddButton(),
    );
  }
}
