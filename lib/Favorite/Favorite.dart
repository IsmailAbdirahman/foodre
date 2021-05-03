import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodre/AppState/AppState.dart';
import 'package:foodre/Home/Home.dart';
import 'package:foodre/Model/PopularFoodModel.dart';
import 'package:provider/provider.dart';
import 'package:foodre/Service/Service.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<String>? iid ;
  Future<List<PopularFoodModel>>? favIdsFromService;


  @override
  void initState() {
    super.initState();
   // favIdsFromService = getFavFood(iid);

  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    iid = appState.foodIdsListt;
    getFavFood(iid!);
    return FutureBuilder<List<PopularFoodModel>>(
        future: getFavFood(iid!),
        builder: (BuildContext context, snashot) {
          if (snashot.hasData) {
            List<PopularFoodModel> popularFav = snashot.data!;
            return ListView.builder(
                itemCount: popularFav.length,
                itemBuilder: (BuildContext context, int index) {
                  return PopularCard(popularFav[index]);
                });
          } else {
            return CircularProgressIndicator();
          }
        }
    );
  }
}
