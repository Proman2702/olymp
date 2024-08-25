import 'package:flutter/material.dart';
import 'package:my_app/src/colors/colors.dart';

// ignore: must_be_immutable
class AppbarGrad extends LinearGradient {
  AppbarGrad()
      : super(
          colors: [
            Color(CustomColors().getAppbarGrad[0]),
            Color(CustomColors().getAppbarGrad[1]),
            Color(CustomColors().getAppbarGrad[2])
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          tileMode: TileMode.decal,
        );
}
