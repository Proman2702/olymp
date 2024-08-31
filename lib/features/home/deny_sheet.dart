import 'package:flutter/material.dart';
import 'package:my_app/src/colors/colors.dart';

class DenySheet extends StatelessWidget {
  const DenySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              alignment: Alignment.center,
              child: const Text(
                'Ошибка! Не все данные заполнены!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
              width: 110,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(CustomColors.mainLightX2)),
                  onPressed: () => Navigator.pop(context),
                  child:
                      Text("Закрыть", style: TextStyle(color: Colors.white))),
            )
          ],
        ),
      ),
    );
  }
}
