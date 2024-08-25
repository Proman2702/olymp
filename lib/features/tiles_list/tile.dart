import 'package:flutter/material.dart';
import 'package:my_app/src/colors/gradients/tile.dart';

class ContainerTile extends Container {
  final int num;
  final child;

  ContainerTile({
    required this.num,
    this.child,
  }) : super(
          alignment: Alignment(0.9, 0),
          height: 90,
          width: 340,
          decoration: BoxDecoration(
            gradient: TileGrad(),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        );
  int get getNum => num;
}
