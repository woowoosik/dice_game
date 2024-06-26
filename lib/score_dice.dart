import 'package:dice_game/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger_plus/logger_plus.dart';

import 'color.dart';

class ScoreDice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScoreDice();
  }
}


class _ScoreDice extends State<ScoreDice> {
  var controller = Get.put(Controller());
  var width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.sizeOf(context).width;

    return Expanded(
        child: Container(
          color: SCORE_DICE,
          child: GetBuilder<Controller>(builder: (_) {
            return Row(
              children: [
                for (var i = 0; i < 5; i++) ...[
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: Image.asset(
                      dice(controller.list[i]),
                      width: width / 5 - 2,
                      height: width / 5 - 2,
                    ),
                  ),

                ],
              ],
            );
          }),
        ),
    );
  }
}

String dice(int diceImage) {
  if (diceImage == 1) {
    return 'assets/dice1.png';
  } else if (diceImage == 2) {
    return 'assets/dice2.png';
  } else if (diceImage == 3) {
    return 'assets/dice3.png';
  } else if (diceImage == 4) {
    return 'assets/dice4.png';
  } else if (diceImage == 5) {
    return 'assets/dice5.png';
  } else {
    return 'assets/dice6.png';
  }
}
