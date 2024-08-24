import 'package:flutter/material.dart';
import 'package:my_app/src/colors/colors.dart';

// ignore: must_be_immutable
class MainGrad extends LinearGradient {
  String hash = '0xff';

  final List<Color> colors;

  MainGrad({required this.colors})
      : super(
          colors: [
            Color(CustomColors().getAppbarGrad[0]),
            Color(CustomColors().getAppbarGrad[1]),
            Color(CustomColors().getAppbarGrad[2])
          ],
        );
}
