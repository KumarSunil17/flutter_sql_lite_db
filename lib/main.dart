import 'package:flutter/material.dart';
import 'package:flutter_sql_lite_db/all_people_page.dart';
import 'package:flutter_sql_lite_db/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQLite',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        appBarTheme: AppBarTheme(color: Colors.blueGrey,),
        iconTheme: IconThemeData(size: 30.0),
      ),
      routes: <String,WidgetBuilder>{
        'All People':(context)=>AllPeople(),
      },
      home: HomePage(),
    );
  }
}
