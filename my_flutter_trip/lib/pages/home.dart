import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_trip/dao/home_dao.dart';
import 'package:my_flutter_trip/home_widget/gridNav.dart';
import 'package:my_flutter_trip/home_widget/loacl_nav.dart';
import 'package:my_flutter_trip/home_widget/sale_box.dart';
import 'package:my_flutter_trip/home_widget/sub_nav.dart';
import 'package:my_flutter_trip/home_widget/webView.dart';
import 'package:my_flutter_trip/model/home_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_flutter_trip/model/home_commen_model.dart';
import 'package:my_flutter_trip/model/home_gridNav.dart';
import 'package:my_flutter_trip/model/home_salesBox.dart';

const NAVGATIONBAR_OFFSECT = 100;

class tripHomePage extends StatefulWidget {
  @override
  _tripHomePageState createState() => _tripHomePageState();
}

class _tripHomePageState extends State<tripHomePage> {

  String _resultStr = '';
  double _appBarAlpha = 0;
  ScrollController _scrollController = ScrollController();
  List <homeCommonModel>_bannerList = [];
  List <homeCommonModel>_loacalNavList = [];
  List <homeCommonModel>_subNavList = [];
  homeModel _homemodel;
  homeGridNavModel _gridNavModel;
  homeSaleBoxModel _boxModel;
  Future loadData()async{
    homeDao.fetchHome().then((homeModel result){
      setState(() {
        _homemodel = result;
        _bannerList = _homemodel.bannerList;
        _loacalNavList = _homemodel.localNavList;
        _subNavList = _homemodel.subNavList;
        _resultStr = result.config.searchUrl;
        _gridNavModel = _homemodel.gridNav;
        _boxModel = _homemodel.salesBox;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      }
    });
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: NotificationListener(
                onNotification:(scrollnotification){
                  if(scrollnotification is ScrollUpdateNotification && scrollnotification.depth==0)
                    {
                      _onscroll(scrollnotification.metrics.pixels);
                    }
                } ,
                child: RefreshIndicator(
                  onRefresh: loadData,
                  child: _listView,
                ),
              ),
          ),
          _navgationBar,
        ],
      ),
    );
  }
   _onscroll(double scrollLength) {
     double alpha = 0;
     alpha = scrollLength / NAVGATIONBAR_OFFSECT;
     if (alpha < 0) {
       alpha = 0;
     } else if (alpha > 1) {
       alpha = 1;
     }
     setState(() {
       _appBarAlpha = alpha;
     });
  }

  Widget get _listView{
    return ListView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.blue),
          height: 220,
          child: Swiper(
            itemCount: _bannerList.length,
            autoplay: true,
            itemBuilder: (BuildContext context, int index){
              homeCommonModel bannerModel = _bannerList[index];
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>webView(
                    url: bannerModel.url,
                    hideAppBar: bannerModel.hideAppBar,
                    statusBarColor: bannerModel.statusBarColor,
                  )));
                },
                child: Image.network(
                  bannerModel.icon,
                  fit: BoxFit.fill,
                ),
              );
            },
            pagination: SwiperPagination(),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7,4, 7, 4),
          child: localNav(localnavList:_loacalNavList),
        ),
        Padding(padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
          child: GridNav(gradeModel:_gridNavModel),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 0),
          child: subNav(subNavList: _subNavList,),
        ),
        Padding(padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: saleBoxPage(saleBox: _boxModel),
        ),
      ],
    );
  }
  Widget get _navgationBar{
    return Opacity(
      opacity: _appBarAlpha,
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        height: 88,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 20),
        child: Text('首页'),
      ),
    );
  }
}


