import 'package:flutter/material.dart';
import 'package:my_app/etc/colors/gradients/tile.dart';

class TileBuilder extends StatelessWidget {
  final int index;
  final Function func;
  const TileBuilder({super.key, required this.index, required this.func});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const SizedBox(height: 110),
        Container(
            alignment: Alignment(0.9, 0),
            height: 90,
            width: 340,
            decoration: BoxDecoration(
              gradient: TileGrad(),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Flexible(child: Text("")),
                IconButton(
                    onPressed: () {
                      func(index);
                    },
                    icon: const Icon(Icons.delete))
              ],
            )),
      ],
    );
  }
}
