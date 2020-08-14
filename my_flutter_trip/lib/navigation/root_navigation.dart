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
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _defoutColor,
              ),
              activeIcon: Icon(
                Icons.home,
                color: _selectColor,
              ),
              title: Text('登录',style: TextStyle(color: _currentPage==0?_selectColor:_defoutColor),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.home,
                  color: _defoutColor,
              ),
              activeIcon: Icon(
                Icons.home,
                color: _selectColor,
              ),
              title: Text('首页',style: TextStyle(color: _currentPage==1?_selectColor:_defoutColor),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _defoutColor,
              ),
              activeIcon: Icon(
                Icons.search,
                color: _selectColor,
              ),
              title: Text('搜索',style: TextStyle(color: _currentPage==2?_selectColor:_defoutColor),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _defoutColor,
              ),
              activeIcon: Icon(
                Icons.person,
                color: _selectColor,
              ),
              title: Text('个人中心',style: TextStyle(color:_currentPage==3?_selectColor:_defoutColor),),
            )
          ]
      ),
    );
  }
}
