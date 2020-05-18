import 'package:shared_preferences/shared_preferences.dart';



class SharedPrefs {
  List<String> gotIds = [];

  Future saveTheId(List<String> ids) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("IDsaved", ids);
  }

  Future<void> getTheID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    gotIds = sharedPreferences.getStringList("IDsaved");
  }
}
