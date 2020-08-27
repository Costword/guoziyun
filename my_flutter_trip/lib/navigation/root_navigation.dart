import 'package:flutter/material.dart';
import 'package:my_flutter_trip/pages/guozi_home_page.dart';
import 'package:my_flutter_trip/pages/home.dart';
import 'package:my_flutter_trip/pages/loginPage.dart';
import 'package:my_flutter_trip/pages/personal.dart';
import 'package:my_flutter_trip/pages/searchPage.dart';

class rootNavigationPage extends StatefulWidget {
  @override
  _rootNavigationPageState createState() => _rootNavigationPageState();
}

class _rootNavigationPageState extends State<rootNavigationPage> {

  final PageController  _pageController = PageController(
    initialPage: 0,
  );
  int _currentPage = 0;
  Color _defoutColor = Colors.grey;
  Color _selectColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          guoziHomePage(),
          tripHomePage(),
          mySearchPage(),
          tripPersonalPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,//显示图标和文字
          currentIndex: _currentPage,
          onTap: (index){
            _pageController.jumpToPage(index);
            print(index.toString());
            setState(() {
              _currentPage = index;
            });
          },
          items:[
            _tableBarItem('首页',Icons.home,0),
            _tableBarItem('布局',Icons.terrain,1),
            _tableBarItem('搜索',Icons.search,2),
            _tableBarItem('我的',Icons.person,3),
          ]
      ),
    );
  }
  _tableBarItem(String title,IconData myicon,int index){

    return  BottomNavigationBarItem(
      icon: Icon(
        myicon,
        color: _defoutColor,
      ),
      activeIcon: Icon(myicon,
        color: _selectColor,
      ),
      title: Text(title,style: TextStyle(color: _currentPage==index?_selectColor:_defoutColor),
      ),
    );
  }
}
