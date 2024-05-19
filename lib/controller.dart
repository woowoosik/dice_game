import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:logger_plus/logger_plus.dart';
import 'dart:math';

class Controller extends GetxController{
  List<int> list = [1,2,3,4,5];
  //var list = List<int>.filled(6, 1, growable: true);


  bool scoreVisible = false;
  String scoreText = '점수 없음';

  void changeDice(int index, int v){
    Logger().d('index: $index  value : $v');
    list[index] = v;
    Logger().d('list : ${list}');

    score();

    Future.delayed(const Duration(milliseconds: 1000), () {
      _scoreVisible();
    });

  }

  void _scoreVisible(){




    scoreVisible = true;
    update();
    Future.delayed(const Duration(milliseconds: 1200), () {
      scoreVisible = false;
      update();
    });

  }



  void score(){
    Logger().e(' score list : ${list} ');

    if(scoreStraight()){
      scoreText = '스트레이트';
    }else if(scoreOfAKind() == 4){
      scoreText = '원페어';
    }else if(scoreOfAKind() == 3){
      Logger().e(' score count() 2 3 : ${count()} ');
      if(count() == 3){
        scoreText = '트리플';
      }else{
        scoreText = '투페어';
      }
    }else if(scoreOfAKind() == 2){

      Logger().e(' score count() 4: ${count()} ');
      if(count() == 4){
        scoreText = '포카트';
      }else{
        scoreText = '풀하우스';
      }
    }else if(scoreOfAKind() == 1){
      scoreText = 'GREAT!!!';
    }else{
      scoreText = '페어 없음';
    }


  }

  int count(){
    var sortList = List.from(list);
    sortList.sort();
    print(sortList);

    var m = 0;
    var count = 1;
    var n = sortList[0];
    for(var i = 1; i< sortList.length; i++){

      if(n == sortList[i]){
        count ++;
      }else{
        m = max(count, m);
        count = 1;
        n = sortList[i];
      }

      print('$n == ${sortList[i]}   :: $count');

    }

    print('$m   :: $count');

    return max(count, m);
  }
  int scoreOfAKind(){
    var sortList = List.from(list);
    sortList.sort();
    print(sortList);

    Set set = {};
    for(var i =0; i< sortList.length; i++){
      set.add(sortList[i]);
    }

    return set.length;
  }

  bool scoreStraight(){
    var sortList = List.from(list);
    sortList.sort();
    print(sortList);

    var n = sortList[0];
    for(var i =1; i< sortList.length; i++){
      Logger().e(' scoreStraight :  ${n}   ${n+1} != ${sortList[i]} ' );
      if(n+1 != sortList[i]){
        return false;
      }else{
        n = n+1;
      }
    }


    return true;

  }





}