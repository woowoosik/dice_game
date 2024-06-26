import 'package:dice_game/controller.dart';
import 'package:dice_game/dice.dart';
import 'package:dice_game/outline_circle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'color.dart';

class Board extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Board();
  }
}

class _Board extends State<Board> with TickerProviderStateMixin {
  bool visible = false;

  var controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        color: BOARD_COLOR,
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: Stack(
          children: [
            Visibility(
              visible: visible,
              child: Stack(
                children: [
                  for (var i = 0; i < 5; i++) ...[
                    Dice(x: 15 * i, y: 15 * (5 - i), index: i),
                  ],
                ],
              ),
            ),
            Visibility(
              visible: !visible,
              child: Center(
                child: OutlineCircleButton(
                    radius: 100.0,
                    borderSize: 1.5,
                    borderColor: Colors.black,
                    foregroundColor: Colors.white,
                    child: const Center(
                      child: Text(
                        '시작',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: START_BUTTON_COLOR),
                      ),
                    ),
                    callback: () {
                      setState(() {
                        visible = true;
                      });
                    }),
              ),
            ),
            GetBuilder<Controller>(builder: (_) {
              return AnimatedOpacity(
                opacity: controller.scoreVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 700),
                child: Visibility(
                  visible: controller.scoreVisible,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.15,
                      child: Text(
                        '${controller.scoreText}',
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

Color fontColor(String t) {
  if (t == '원페어') {
    return color[0];
  } else if (t == '투페어') {
    return color[1];
  } else if (t == '트리플') {
    return color[2];
  } else if (t == '포카드') {
    return color[3];
  } else if (t == '풀하우스') {
    return color[4];
  } else if (t == '스트레이트') {
    return color[5];
  } else if (t == 'GREAT!!!') {
    return color[6];
  } else {
    return color[7];
  }
}
