import 'package:flutter/material.dart';
import 'package:my_app/etc/colors/colors.dart';
import 'package:my_app/etc/colors/gradients/appbar.dart';
import 'package:my_app/repositories/ip.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 190,
                    height: 45,
                    child: TextField(
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black87),
                      onChanged: (value) {
                        setState(() {
                          Ip.ip = value;
                        });
                      },
                      maxLength: 16,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: "Ввод другого IP сервера",
                        labelStyle: TextStyle(color: Colors.black45),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(CustomColors.bright)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 35,
                    width: 115,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(CustomColors.mainLightX2)),
                        onPressed: () => setState(() {
                              Ip.ip = Ip.defaultIp;
                            }),
                        child: const Text("Сбросить",
                            style: TextStyle(color: Colors.white))),
                  )
                ],
              ),
              SizedBox(height: 20),
              Text("IP сервера: ${Ip.ip}",
                  style: TextStyle(color: Color(CustomColors.main)))
            ],
          ),
        ));
  }
}
