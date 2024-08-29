import 'package:flutter/material.dart';
import 'package:my_app/src/colors/gradients/appbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 4,
          toolbarHeight: 70,
          shadowColor: Colors.deepPurple,
          leadingWidth: 50,
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: AppbarGrad()),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
            iconSize: 35,
            color: Colors.white,
          ),
          title: Center(
            child: Container(
              padding: const EdgeInsets.only(right: 30),
              child: const Text(
                "Настройки",
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          )),
    );
  }
}
