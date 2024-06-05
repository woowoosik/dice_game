import 'dart:math';

import 'package:dice_game/controller.dart';
import 'package:dice_game/cube.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger_plus/logger_plus.dart';

class Dice extends StatefulWidget {
  final int x;
  final int y;
  final int index;

  Dice({super.key, required this.x, required this.y, required this.index});

  @override
  State<StatefulWidget> createState() {
    return _Dice();
  }
}

class _Dice extends State<Dice> with TickerProviderStateMixin {
  final double _size = 50.0;

  var padding = 0.07;

  late AnimationController animationController;
  late Animation<double> animationX;
  late Animation<double> animationY;

  var diceClick = false;
  double beginX = Random().nextDouble() * pi * 2;
  double beginY = Random().nextDouble() * pi * 2;

  double endX = Random().nextDouble() * pi * 2;
  double endY = Random().nextDouble() * pi * 2;

  var width = 0;
  var height = 0;

  var controller = Get.put(Controller());

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(microseconds: 1000000),
      vsync: this,
    );

    animationX =
        Tween<double>(begin: 0, end: endX).animate(animationController);
    animationY =
        Tween<double>(begin: 0, end: endY).animate(animationController);

    diceRoll();

    super.initState();
  }

  var mapXsize;
  var mapYsize;

  @override
  Widget build(BuildContext context) {
    mapXsize = MediaQuery.sizeOf(context).width;
    mapYsize = MediaQuery.sizeOf(context).height * 0.8;

    var x = (mapXsize * 3 - widget.x) / 30;
    var y = (mapYsize * 3 - widget.y) / 30;
    animationController.addListener(() {
      setState(() {});
    });

    return Stack(children: <Widget>[
      // Cube
      GestureDetector(
        onDoubleTap: () {
          diceRoll();
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            _width(animationY.value * x + widget.x) - _size,
            _height(animationX.value * y + widget.y) - _size,
            mapXsize - _width(animationY.value * x + widget.x),
            mapYsize - _height(animationX.value * y + widget.y),
          ),
          child: Container(
            child: Cube(
              x: (animationX.value) % (pi * 2),
              y: (animationY.value) % (pi * 2),
              size: _size,
            ),
          ),
        ),
      ),
    ]);
  }

  dynamic _width(dynamic y) {
    if (y >= (mapXsize)) {
      if (y >= (mapXsize * 2 - _size)) {
        return (y - mapXsize * 2) + _size * 2;
      }

      return mapXsize - (y - mapXsize);
    } else if (y < _size) {
      return _size - y + _size;
    } else {
      return y;
    }
  }

  dynamic _height(dynamic x) {
    if (x >= (mapYsize)) {
      if (x >= (mapYsize * 2 - _size)) {
        return (x - mapYsize * 2) + _size * 2;
      }

      return mapYsize - (x - mapYsize);
    } else if (x < _size) {
      return _size - x + _size;
    } else {
      return x;
    }
  }

  void diceRoll() {
    animationController.repeat();
    animationController.reset();
    setState(() {
      endX = Random().nextDouble() * pi * 6;
      endY = Random().nextDouble() * pi * 6;

      var s = front(
          endX % (pi * 2), endY % (pi * 2), (-(pi / 2) + endY) % (pi * 2));

      controller.changeDice(widget.index, s);
      if (s == 1) {
        if (0 <= endX % (pi * 2) && endX % (pi * 2) < (pi / 2) / 2) {
          endX = endX - endX % (pi * 2) + pi * 2 + padding;
        } else {
          endX = endX - endX % (pi * 2) + pi * 2 - padding;
        }
      } else if (s == 6) {
        if (endX <= pi) {
          endX = endX - endX % (pi * 2) + pi + pi * 2 - padding;
        } else {
          endX = endX - endX % (pi * 2) + pi + pi * 2 + padding;
        }
      } else {
        endX = endX - endX % (pi * 2) + pi * 2;
        if (0 <= endX % (pi * 2) && endX % (pi * 2) < pi - (pi / 2)) {
          endX += (pi / 2 - padding);
        } else if (pi / 2 <= endX % (pi * 2) && endX % (pi * 2) < pi + pi / 2) {
          endX += (pi / 2 + padding);
        } else if (pi + pi / 2 <= endX % (pi * 2) &&
            endX % (pi * 2) < pi + pi + pi / 2) {
          endX += (pi + pi / 2 + padding);
        } else if (pi + 0 <= endX % (pi * 2) &&
            endX % (pi * 2) < pi + pi - (pi / 2)) {
          endX += (pi + pi / 2 - padding);
        }

        if (s == 2) {
          if (endY < pi) {
            endY = endY - endY % (pi * 2) + pi * 2 + padding;
          } else {
            endY = endY - endY % (pi * 2) + pi * 2 - padding;
          }
        } else if (s == 3) {
          if (endY <= pi / 2) {
            endY = endY - endY % (pi * 2) + pi / 2 + pi * 2 - padding;
          } else {
            endY = endY - endY % (pi * 2) + pi / 2 + pi * 2 + padding;
          }
        } else if (s == 4) {
          if (endY <= (pi + pi / 2)) {
            endY = endY - endY % (pi * 2) + pi + pi / 2 + pi * 2 - padding;
          } else {
            endY = endY - endY % (pi * 2) + pi + pi / 2 + pi * 2 + padding;
          }
        } else if (s == 5) {
          if (endY <= pi) {
            endY = endY - endY % (pi * 2) + pi + pi * 2 - padding;
          } else {
            endY = endY - endY % (pi * 2) + pi + pi * 2 + padding;
          }
        }
      }

      animationX =
          Tween<double>(begin: beginX, end: endX).animate(animationController);
      animationY =
          Tween<double>(begin: beginY, end: endY).animate(animationController);

      beginX = endX;
      beginY = endY;

      if (animationController.isDismissed) {
        animationController.forward();
      } else if (animationController.isCompleted) {
        animationController.forward();
      } else {
        Logger().e('else');
      }
    });
  }
}

int front(double x, double y, double z) {
  double _halfPi = pi / 2;
  double _oneHalfPi = pi + pi / 2;

  var yy = y % pi;
  var zz = z % pi;

  var frontY = min((pi - yy).abs(), yy);
  var frontZ = min((pi - zz).abs(), zz);

  var sum = (y + (x > pi ? pi : 0.0)).abs() % (pi * 2);

  var m = min(frontY, frontZ);
  if (0 <= x && x < _halfPi / 2 || (pi * 2 - _halfPi / 2) <= x && x < pi * 2) {
    return 1;
  } else if (_halfPi + _halfPi / 2 <= x && x < pi + _halfPi / 2) {
    return 6;
  } else {
    if (m == frontY) {
      if (sum < _halfPi || sum > _oneHalfPi) {
        return 2;
      } else {
        return 5;
      }
    } else {
      if (sum < pi) {
        return 3;
      } else {
        return 4;
      }
    }
  }
}
