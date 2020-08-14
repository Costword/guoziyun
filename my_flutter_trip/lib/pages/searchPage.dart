import 'package:flutter/material.dart';
import 'package:my_flutter_trip/home_widget/new_search_bar.dart';
import 'package:my_flutter_trip/home_widget/search_bar.dart';

class mySearchPage extends StatefulWidget {
  @override
  _mySearchPageState createState() => _mySearchPageState();
}

class _mySearchPageState extends State<mySearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人中心'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        alignment: Alignment.topCenter,
        child:  Container(
          child: searchBar(),
        ),
      ),
    );
  }
}
