import 'package:flutter/material.dart';

//首页

class tripPersonalPage extends StatefulWidget {
  @override
  _tripPersonalPage createState() => _tripPersonalPage();
}

class _tripPersonalPage extends State<tripPersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人中心'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.blue),
        child: Text('个人中心'),
      ),
    );
  }
}

