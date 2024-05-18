import 'package:get/get.dart';
import 'package:logger_plus/logger_plus.dart';

class Controller extends GetxController{
  List<int> list = [1,2,3,4,5];
  //var list = List<int>.filled(6, 1, growable: true);


  void changeDice(int index, int v){
    Logger().d('index: $index  value : $v');
    list[index] = v;
    Logger().d('list : ${list}');
    update();
  }


}