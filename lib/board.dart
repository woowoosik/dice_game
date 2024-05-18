import 'package:dice_game/controller.dart';
import 'package:dice_game/dice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Board extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Board();
  }
}

class _Board extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.orangeAccent,
        height: MediaQuery.sizeOf(context).height * 0.75,
        child: Stack(
          children: [
            for (var i = 0; i < 5; i++) ...[
              Dice(x: 15 * i, y: 15 * (5 - i), index: i),
            ]
          ],


        ),
      ),
    );
  }
}



