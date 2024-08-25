import 'package:flutter/material.dart';
import 'package:my_app/src/colors/colors.dart';

// ignore: must_be_immutable
class TileGrad extends LinearGradient {
  TileGrad()
      : super(
          colors: [
            Color(CustomColors().getTileGrad[0]),
            Color(CustomColors().getTileGrad[1])
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          tileMode: TileMode.decal,
        );
}
