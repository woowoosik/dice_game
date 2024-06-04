
import 'package:dice_game/board.dart';
import 'package:dice_game/score_dice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home:
        Scaffold(
          body: Column(
            children: [
              Board(),
              ScoreDice(),
            ],
          ),
        )
    )
);