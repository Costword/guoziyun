
import 'package:my_flutter_trip/model/home_commen_model.dart';

class homeSaleBoxModel{
  final String icon;
  final String moreUrl;
  final homeCommonModel bigCard1;
  final homeCommonModel bigCard2;
  final homeCommonModel smallCard1;
  final homeCommonModel smallCard2;
  final homeCommonModel smallCard3;
  final homeCommonModel smallCard4;
  homeSaleBoxModel({this.icon, this.moreUrl, this.bigCard1, this.bigCard2, this.smallCard1, this.smallCard2, this.smallCard3, this.smallCard4});

  factory homeSaleBoxModel.fromJson(Map<String,dynamic>json){
    return homeSaleBoxModel(
      icon: json['icon'],
      moreUrl: json['moreUrl'],
      bigCard1: homeCommonModel.fromJson(json['bigCard1']),
      bigCard2: homeCommonModel.fromJson(json['bigCard2']),
      smallCard1: homeCommonModel.fromJson(json['smallCard1']),
      smallCard2: homeCommonModel.fromJson(json['smallCard2']),
      smallCard3: homeCommonModel.fromJson(json['smallCard3']),
      smallCard4: homeCommonModel.fromJson(json['smallCard4']),
    );
  }
}


