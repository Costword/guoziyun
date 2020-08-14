import 'package:flutter/material.dart';

class guozirecstudyModel {
  final List<inslistModel> inslist;
  final List<ywModel> yw;

  guozirecstudyModel({this.inslist, this.yw});

  factory guozirecstudyModel.fromJson(Map<String, dynamic> json) {
    var inslistjson = json['inslist'] as List;
    List<inslistModel> inslistmodel =
        inslistjson.map((e) => inslistModel.frorJson(e)).toList();

    var ywjson = json['yw'] as List;
    List<ywModel> ywmodel = ywjson.map((e) => ywModel.fromJson(e)).toList();
    return guozirecstudyModel(
      inslist: inslistmodel,
      yw: ywmodel,
    );
  }
}

class inslistModel {
  final int id;
  final int inscription_code;
  final String source_url;
  final int depart_index;
  final int char_index;
  final iinfoModel iinfo;

  inslistModel(
      {this.id,
      this.inscription_code,
      this.source_url,
      this.depart_index,
      this.char_index,
      this.iinfo});

  factory inslistModel.frorJson(Map<String, dynamic> json) {
    var iinfojson = json['iinfo'] as Map;
    iinfoModel informodel = iinfoModel.fromJson(iinfojson);
    return inslistModel(
      id: json['id'],
      inscription_code: json['inscription_code'],
      source_url: json['source_url'],
      depart_index: json['depart_index'],
      char_index: json['char_index'],
      iinfo: informodel,
    );
  }
}

class iinfoModel {
  final int id;
  final int inscription_code;
  final String char_name;
  final int depart_index;
  final int char_index;
  final int page;
  final int pagenum;

  iinfoModel(
      {this.id,
      this.inscription_code,
      this.char_name,
      this.depart_index,
      this.char_index,
      this.page,
      this.pagenum});

  factory iinfoModel.fromJson(Map<String, dynamic> json) {
    return iinfoModel(
      id: json['id'],
      inscription_code: json['inscription_code'],
      char_name: json['char_name'],
      depart_index: json['depart_index'],
      char_index: json['char_index'],
      page: json['page'],
      pagenum: json['pagenum'],
    );
  }
}

class ywModel {
  final int zi_id;
  final String zi;

  ywModel({this.zi_id, this.zi});

  factory ywModel.fromJson(Map<String, dynamic> json) {
    return ywModel(
      zi_id: json['zi_id'],
      zi: json['zi'],
    );
  }
}
