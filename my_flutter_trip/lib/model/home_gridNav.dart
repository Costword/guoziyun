
import 'package:my_flutter_trip/model/home_commen_model.dart';

class homeGridNavModel{
  final homeGridNavItemModel hotel;
  final homeGridNavItemModel flight;
  final homeGridNavItemModel travel;

  homeGridNavModel({this.hotel, this.flight, this.travel});

  factory homeGridNavModel.fromJson(Map<String,dynamic>json){
    return homeGridNavModel(
      hotel: homeGridNavItemModel.fromJson(json['hotel']),
      flight: homeGridNavItemModel.fromJson(json['flight']),
      travel: homeGridNavItemModel.fromJson(json['travel']),
    );
  }
}

class homeGridNavItemModel{

  final String startColor;
  final String endColor;
  final homeCommonModel mainItem;
  final homeCommonModel item1;
  final homeCommonModel item2;
  final homeCommonModel item3;
  final homeCommonModel item4;

  homeGridNavItemModel({this.startColor, this.endColor, this.mainItem, this.item1, this.item2, this.item3, this.item4});

  factory homeGridNavItemModel.fromJson(Map<String,dynamic>json){
    return homeGridNavItemModel(
      startColor: json['startColor'],
      endColor: json['endColor'],
      mainItem: homeCommonModel.fromJson(json['mainItem']),
      item1: homeCommonModel.fromJson(json['item1']),
      item2: homeCommonModel.fromJson(json['item2']),
      item3: homeCommonModel.fromJson(json['item3']),
      item4: homeCommonModel.fromJson(json['item4']),
    );
  }

  Map<String,dynamic>toJson (){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['startColor'] = this.startColor;
    data['endColor'] = this.endColor;
    data['mainItem'] = this.mainItem.toJson();
    data['item1'] = this.item1.toJson();
    data['item2'] = this.item2.toJson();
    data['item3'] = this.item3.toJson();
    data['item4'] = this.item4.toJson();
    return data;
  }
}