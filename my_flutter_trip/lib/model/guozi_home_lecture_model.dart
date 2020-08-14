import 'package:flutter/material.dart';

class guoziHomelectureModel {
  final int id;
  final String name;
  final String teacher_name;
  final String imgurl;
  final int isvideo;
  final String count;
  final int icon;

  guoziHomelectureModel(
      {this.id,
      this.name,
      this.teacher_name,
      this.imgurl,
      this.isvideo,
      this.count,
      this.icon});

  factory guoziHomelectureModel.fromJson(Map<String, dynamic> json) {
    return guoziHomelectureModel(
      id: json['id'],
      name: json['name'],
      teacher_name: json['teacher_name'],
      imgurl: json['imgurl'],
      isvideo: json['isvideo'],
      count: json['count'],
      icon: json['icon'],
    );
  }
}
