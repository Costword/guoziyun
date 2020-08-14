import 'package:flutter/material.dart';

class guoziBannerModel{
  final int id;
  final String title;
  final String image;
  final String url;
  final int type;
  final String color;
  guoziBannerModel({this.id, this.title, this.image, this.url, this.type, this.color});
  factory guoziBannerModel.fromJson(Map<String,dynamic> json){
    return guoziBannerModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      url: json['url'],
      type: json['type'],
      color: json['color'],
    );
  }
}