import 'package:my_flutter_trip/model/home_commen_model.dart';
import 'package:my_flutter_trip/model/home_gridNav.dart';
import 'package:my_flutter_trip/model/home_salesBox.dart';
import 'home_config.dart';

class homeModel {
  final homeConfigeModel config;
  final List<homeCommonModel> bannerList;
  final List<homeCommonModel> localNavList;
  final List<homeCommonModel> subNavList;
  final homeGridNavModel gridNav;
  final homeSaleBoxModel salesBox;

  homeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.subNavList,
      this.gridNav,
      this.salesBox});

  factory homeModel.fromJson(Map<String, dynamic> json) {

    var locabannerListJson = json['bannerList'] as List;
    List<homeCommonModel> bannerList =
    locabannerListJson.map((i) => homeCommonModel.fromJson(i)).toList();

    var localNavListJson = json['localNavList'] as List;
    List<homeCommonModel> localNavList =
    localNavListJson.map((i) => homeCommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<homeCommonModel> subNavList =
    subNavListJson.map((i) => homeCommonModel.fromJson(i)).toList();

    return homeModel(
      config: homeConfigeModel.fromJson(json['config']),
      bannerList: bannerList,
      localNavList: localNavList,
      subNavList: subNavList,
      gridNav: homeGridNavModel.fromJson(json['gridNav']),
      salesBox: homeSaleBoxModel.fromJson(json['salesBox']),
    );
  }
}
