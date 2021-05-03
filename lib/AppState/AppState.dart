import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class AppState extends ChangeNotifier {
  Box<String>? idListsBox;
  List<String>? _foodIdsListt = [];

  get foodIdsListt => _foodIdsListt;

  AppState() {
    idListsBox = Hive.box<String>("idLists");
    getDataFromHive();
  }

  saveDataIntoHive(String foodId) {
    if (!getDataFromHive(foodId: int.parse(foodId))) {
      idListsBox!.put(int.parse(foodId), foodId);
      print("THE RE ADDED KEY IS ${int.parse(foodId)}");
    } else {
      idListsBox!.delete(int.parse(foodId));
      print("THE RE REMOVED KEY IS ${int.parse(foodId)}");

    }

    notifyListeners();
  }

  bool getDataFromHive({int? foodId}) {
    if (idListsBox != null) {
      List<int> keys = idListsBox!.keys.cast<int>().toList();
      keys.forEach((i) {
        idListsBox!.get(i);
        _foodIdsListt!.remove(idListsBox!.get(i));

        _foodIdsListt!.add(idListsBox!.get(i)!);
      });
    }
    if (idListsBox!.containsKey(foodId)) {
      return true;
    } else {
      return false;
    }
  }
}
