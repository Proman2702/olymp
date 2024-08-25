// ignore: unused_import
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/colors/appbar_grad.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 4,
          toolbarHeight: 70,
          shadowColor: Colors.deepPurple,
          leadingWidth: 20,
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: MainGrad()),
          ),
          title: Container(
            padding: const EdgeInsets.all(5),
            child: const Text(
              "AI App",
              style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
              color: Colors.white,
              iconSize: 35,
            ),
            Container(width: 10)
          ]),
      body: Center(
          child: Container(
        child: Column(children: <Widget>[Text("анти-бурда")]),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 161, 29, 201),
        onPressed: () {},
        child: const Center(
            child: Text(
          "+",
          textScaler: TextScaler.linear(2.4),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        )),
      ),
    );
  }
}
