import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodre/DisplayData.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<String>("idLists");


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DisplayData()
    );
  }
}
