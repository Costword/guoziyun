import 'package:flutter/material.dart';
import 'guozi_home_item_model.dart';
import 'guozi_home_lecture_model.dart';
import 'guozi_home_recstudy_model.dart';

class guoziHomeModel {
  final List<guoziHomeItemModel> mao;
  final List<guoziHomeItemModel> yin;
  final List<guoziHomeItemModel> yuwen;
  final List<guoziHomeItemModel> inscription;
  final List<guoziHomelectureModel> lecture;
  final List<guoziHomeItemModel> poem;
  final List<guoziHomeItemModel> story;
  final List<guoziHomeItemModel> shufa;
  final guozirecstudyModel recstudy;

  guoziHomeModel(
      {this.mao,
      this.yin,
      this.yuwen,
      this.inscription,
      this.lecture,
      this.poem,
      this.story,
      this.shufa,
      this.recstudy});

  factory guoziHomeModel.formJson(Map<String, dynamic> json) {

    var maojson = json['mao'] as List;
    List<guoziHomeItemModel> maoList =
    maojson.map((data) => guoziHomeItemModel.fromJson(data)).toList();

    var yinjson = json['yin'] as List;
    List<guoziHomeItemModel> yinList =
    yinjson.map((e) => guoziHomeItemModel.fromJson(e)).toList();

    var yuwenjson = json['yuwen'] as List;
    List<guoziHomeItemModel> yuwenList =
    yuwenjson.map((e) => guoziHomeItemModel.fromJson(e)).toList();

    var inscriptionjson = json['inscription'] as List;
    List<guoziHomeItemModel> inscriptionList =
    inscriptionjson.map((e) => guoziHomeItemModel.fromJson(e)).toList();

    var lecturejson = json['lecture'] as List;
    List<guoziHomelectureModel> lectureList =
    lecturejson.map((e) => guoziHomelectureModel.fromJson(e)).toList();

    var poemjson = json['poem'] as List;
    List<guoziHomeItemModel> poemList =
    poemjson.map((e) => guoziHomeItemModel.fromJson(e)).toList();

    var storyjson = json['story'] as List;
    List<guoziHomeItemModel> storyList =
    storyjson.map((e) => guoziHomeItemModel.fromJson(e)).toList();

    var shufajson = json['shufa'] as List;
    List<guoziHomeItemModel> shufaList =
    shufajson.map((e) => guoziHomeItemModel.fromJson(e)).toList();
    return guoziHomeModel(
      mao: maoList,
      yin: yinList,
      yuwen: yuwenList,
      inscription: inscriptionList,
      lecture: lectureList,
      poem: poemList,
      story: storyList,
      shufa: shufaList,
      recstudy: guozirecstudyModel.fromJson(json['recstudy']),
    );
  }
}
