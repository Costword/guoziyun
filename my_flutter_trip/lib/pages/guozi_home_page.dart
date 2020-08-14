import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_flutter_trip/home_widget/guozi_cell_heaer.dart';
import 'package:my_flutter_trip/home_widget/webView.dart';
import 'package:my_flutter_trip/model/guozi_banner_model.dart';
import 'package:my_flutter_trip/model/guozi_home_item_model.dart';
import 'package:my_flutter_trip/model/guozi_home_lecture_model.dart';
import 'package:my_flutter_trip/model/guozi_home_model.dart';
import 'package:my_flutter_trip/model/guozi_home_recstudy_model.dart';
import 'package:my_flutter_trip/network/m_networking.dart';
import 'package:my_flutter_trip/urls/my_urls.dart';
import 'dart:convert';

const NAVGATIONBAR_OFFSECT = 100;

Color MAIN_BACKGROUND_COLOR = Color(int.parse('0xfffafafa'));

class guoziHomePage extends StatefulWidget {
  @override
  _guoziHomePageState createState() => _guoziHomePageState();
}

class _guoziHomePageState extends State<guoziHomePage> {
  MyUrlsWidget urlsWidget = MyUrlsWidget();
  List<guoziBannerModel> _bannerModelList = [];
  guoziHomeModel _homeListModel;
  Color currentBaseColor = Color(int.parse('0xfffafafa'));
  double _appBarAlpha = 0;
  ScrollController _scrollController = ScrollController();
  List<String> _categoryNameList = ['毛笔', '硬笔', '碑帖', '语文', '诗词'];
  guozirecstudyModel _recstudyModel;
  List<guoziHomeItemModel> _maobiList = [];
  List<guoziHomeItemModel> _yingbiList = [];
  List<guoziHomeItemModel> _ywList = [];
  List<guoziHomeItemModel> _beitieList = [];
  List<guoziHomeItemModel> _pomeList = [];
  List<guoziHomeItemModel> _storyList = [];
  List<guoziHomelectureModel> _lectureList = [];

  Future _loadMianData() {
    _getBannerList();
    _getHomeListData();
    return null;
  }

  Future _getBannerList() async {
    Map<String, dynamic> params = {};
    var result = await m_postUrlWithParams(urlsWidget.homeBannerList, params);
    var josnData = json.decode(result.toString());
    int code = josnData['code'];
    String msg = josnData['msg'];
    if (code == 200) {
      print('请求成功：$josnData');
      var bannerJsonList = josnData['data']['list'] as List;
      setState(() {
        _bannerModelList =
            bannerJsonList.map((i) => guoziBannerModel.fromJson(i)).toList();
        if (_bannerModelList.length > 0) {
          String color = _bannerModelList[0].color;
          color = color.substring(1, color.length);
          currentBaseColor = Color(int.parse('0xff' + color));
        }
      });
    } else {
      print('请求成功：$msg');
    }
    return null;
  }

  Future _getHomeListData() async {
    Map<String, dynamic> params = {};
    params['version'] = '1';
    var result = await m_postUrlWithParams(urlsWidget.homeList, params);
    var josnData = json.decode(result.toString());
    int code = josnData['code'];
    String msg = josnData['msg'];
    if (code == 200) {
      var rec = josnData['data'];
      _homeListModel = guoziHomeModel.formJson(rec);
      _recstudyModel = _homeListModel.recstudy;
      _lectureList = _homeListModel.lecture;
      _maobiList = _homeListModel.mao;
      _yingbiList = _homeListModel.yin;
      _ywList = _homeListModel.yuwen;
      _beitieList = _homeListModel.inscription;
      _pomeList = _homeListModel.poem;
      _storyList = _homeListModel.story;
    } else {
      print('请求成功：$msg');
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {}
    });
    _loadMianData();
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
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: NotificationListener(
          onNotification: (scrollnotification) {
            if (scrollnotification is ScrollUpdateNotification &&
                scrollnotification.depth == 0) {
              _onScroll(scrollnotification.metrics.pixels);
            }
          },
          child: RefreshIndicator(
            onRefresh: _loadMianData,
            child: Stack(
              children: <Widget>[
                ListView(
                  controller: _scrollController,
                  children: <Widget>[
                    _banner,
                    _categoryMenu,
                    recstudyCard,
                    yanbianCard,
                    artLessonCard,
                    maobiLessCard,
                    yingbiLessCard,
                    yuwenLessCard,
                    beitieLessCard,
                    poemLessCard,
                    storyLessCard,
                  ],
                ),
                _navgationBar,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _navgationBar {
    return Opacity(
      opacity: _appBarAlpha,
      child: Container(
        decoration: BoxDecoration(color: MAIN_BACKGROUND_COLOR),
        height: 88,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 20),
        child: Text('首页'),
      ),
    );
  }

  Widget get _banner {
    return Container(
      decoration: BoxDecoration(color: MAIN_BACKGROUND_COLOR),
      height: 260,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: currentBaseColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6)),
                ),
                height: 200,
              ),
              Container(
                decoration: BoxDecoration(color: MAIN_BACKGROUND_COLOR),
                height: 60,
              ),
            ],
          ),
          Container(
            height: 260,
            padding: EdgeInsets.fromLTRB(20, 64, 20, 20),
            child: PhysicalModel(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAlias,
              child: Swiper(
                itemCount: _bannerModelList.length,
                autoplay: true,
                autoplayDelay: 5000,
                onIndexChanged: (index) {
                  setState(() {
                    print('当前是第$index');
                    String color = _bannerModelList[index].color;
                    color = color.substring(1, color.length);
                    currentBaseColor = Color(int.parse('0xff' + color));
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  guoziBannerModel bannerModel = _bannerModelList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => webView(
                                    url: bannerModel.url,
                                  )));
                    },
                    child: Image.network(
                      bannerModel.image,
                      fit: BoxFit.fill,
                    ),
                  );
                },
                pagination: SwiperPagination(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget get _categoryMenu {
    return Container(
      decoration: BoxDecoration(color: MAIN_BACKGROUND_COLOR),
      padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _categoryItems(),
      ),
    );
  }

  Widget get recstudyCard {
    return Container(
      decoration: BoxDecoration(color: MAIN_BACKGROUND_COLOR),
      padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: Stack(
        children: <Widget>[
          Image.asset(
            'images/v2_shouye_tjbg@3x.png',
            width: MediaQuery.of(context).size.width - 50,
            height: 200,
            fit: BoxFit.fill,
          ),
          Container(
            decoration: BoxDecoration(),
            margin: EdgeInsets.only(left: 55),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: _beitieItems(),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                Row(
                  children: _ywItems(),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget get yanbianCard {
    return Container(
      decoration: BoxDecoration(color: MAIN_BACKGROUND_COLOR),
      padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: Image.asset(
        'images/ludeyanbian.gif',
        fit: BoxFit.fitWidth,
        height: 200,
      ),
    );
  }

  Widget get artLessonCard {
    return Container(
        decoration: BoxDecoration(color: MAIN_BACKGROUND_COLOR),
        padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
        child: Column(
          children: <Widget>[
            homeCellHeader(
              title: '艺术大讲堂',
              hildRight: false,
              rightClickBack: _moreArtLesson,
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              height: 180,
              child: Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _artItems(),
                ),
              ),
            ),
          ],
        ));
  }

  Widget get maobiLessCard {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: _normalItems('毛笔课程', _maobiList),
    );
  }

  Widget get yingbiLessCard {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: _normalItems('硬笔课程', _yingbiList),
    );
  }

  Widget get yuwenLessCard {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: _normalItems('语文课程', _ywList),
    );
  }

  Widget get beitieLessCard {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: _normalItems('碑帖课程', _beitieList),
    );
  }

  Widget get poemLessCard {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: _normalItems('诗词课程', _pomeList),
    );
  }

  Widget get storyLessCard {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: _normalItems('故事课程', _storyList),
    );
  }

  _normalItems(String titlestr, List<guoziHomeItemModel> items) {
    List<Widget> noritems = [];
    if (items == null || items.length == 0) return null;
    items.forEach((element) {
      noritems.add(_normalitem(element));
    });
    return Column(
      children: <Widget>[
        homeCellHeader(
          title: titlestr,
          hildRight: false,
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: noritems,
          ),
        ),
      ],
    );
  }

  _normalitem(guoziHomeItemModel itemModel) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: 170,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                  image: NetworkImage(itemModel.imgurl), fit: BoxFit.fill),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5, top: 5),
            width: 170,
            child: Row(
              children: <Widget>[
                Text(
                  itemModel.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.only(left: 5, right: 5),
            width: 170,
            child: Text(
              itemModel.describe,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }

  _beitieItems() {
    List<Widget> beitieItems = [];
    if (_recstudyModel == null) return beitieItems;
    _recstudyModel.inslist.forEach((element) {
      beitieItems.add(_beitieitem(element));
    });
    return beitieItems;
  }

  _beitieitem(inslistModel insmodel) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(),
        child: Image.network(
          insmodel.source_url,
          width: 80,
          height: 80,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  _ywItems() {
    List<Widget> Items = [];
    if (_recstudyModel == null) return Items;
    _recstudyModel.yw.forEach((element) {
      Items.add(_yuitem(element));
    });
    return Items;
  }

  _yuitem(ywModel ywmodl) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(),
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'images/font_bg.png',
              width: 80,
              height: 80,
              fit: BoxFit.fill,
            ),
            Container(
              decoration: BoxDecoration(),
              width: 80,
              height: 80,
              alignment: Alignment.center,
              child: Text(
                ywmodl.zi,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  _artItems() {
    List<Widget> items = [];
    if (_lectureList.length == 0) return items;
    _lectureList.forEach((element) {
      items.add(_artitem(element));
    });
    return items;
  }

  _artitem(guoziHomelectureModel lectureModel) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: 170,
          decoration: BoxDecoration(color: MAIN_BACKGROUND_COLOR),
          child: Column(
            children: <Widget>[
              Container(
                child: Image.network(
                  lectureModel.imgurl,
                  height: 100,
                  alignment: AlignmentDirectional.topEnd,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, top: 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      lectureModel.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.grey,
                            size: 18,
                          ),
                        ),
                        Text(
                          lectureModel.teacher_name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        lectureModel.count,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _categoryItems() {
    List<Widget> items = [];
    for (int i = 0; i < _categoryNameList.length; i++) {
      String title = _categoryNameList[i];
      items.add(_categoryItem(title, i));
    }
    return items;
  }

  _categoryItem(String name, int Index) {
    int num = Index + 1;
    String imageName = 'images/v2_shouye_category_' + '$num' + '@3x.png';
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Image.asset(
            imageName,
            width: 30,
            height: 30,
            fit: BoxFit.fill,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              name,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  _moreArtLesson() {}

  _onScroll(double offect) {
    double alpha = 0;
    alpha = offect / NAVGATIONBAR_OFFSECT;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _appBarAlpha = alpha;
    });
    print(offect);
  }
}
