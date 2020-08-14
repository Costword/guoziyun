import 'package:flutter/material.dart';

class guoziHomeItemModel {
  final int id;
  final String name;
  final String imgurl;
  final int type;
  final int classify;
  final String describe;
  final String author;
  final int show_video;


  guoziHomeItemModel(
      {this.id,
      this.name,
      this.imgurl,
      this.type,
      this.classify,
      this.describe,
      this.author,
      this.show_video});

  factory guoziHomeItemModel.fromJson(Map<String, dynamic> json) {
    return guoziHomeItemModel(
      id: json['id'],
      name: json['name'],
      imgurl: json['imgurl'],
      type: json['type'],
      classify: json['classify'],
      describe: json['describe'],
      author: json['author'],
      show_video: json['show_video'],
    );
  }
}
