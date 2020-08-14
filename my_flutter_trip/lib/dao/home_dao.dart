import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_flutter_trip/model/home_model.dart';

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

class homeDao{
  static Future<homeModel> fetchHome() async {
    final response = await http.get(HOME_URL);
    if(response.statusCode == 200)
      {
        Utf8Decoder utf8decoder = Utf8Decoder();
        var result = json.decode(utf8decoder.convert(response.bodyBytes));
        return homeModel.fromJson(result);
      }else{
      throw Exception('加载首页地址失败');
    }
  }
}