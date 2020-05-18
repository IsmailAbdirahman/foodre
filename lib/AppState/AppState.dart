import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class AppState extends ChangeNotifier {
  Box<String> idListsBox;
  List<String> foodIdsListt = [];

  AppState() {
    idListsBox = Hive.box<String>("idLists");
    getDataFromHive();
  }

  saveDataIntoHive(String foodId) {


    if(!foodIdsListt.contains(foodId)){
      idListsBox.add(foodId);

    }else{

      print("ALready exist");
    }
    notifyListeners();

  }

  getDataFromHive() {
    if (idListsBox != null) {
      List<int> keys = idListsBox.keys.cast<int>().toList();
      keys.forEach((i) {
        idListsBox.get(i);
        foodIdsListt.add(idListsBox.get(i));
      });
      print(
          "THE VALUES ARE-----------------------------------------  ${foodIdsListt}");


      notifyListeners();
    }
  }
}
