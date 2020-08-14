
class homeConfigeModel{
  final String searchUrl;
  homeConfigeModel({this.searchUrl});
  factory homeConfigeModel.fromJson(Map<String,dynamic>json){
    return  homeConfigeModel(
      searchUrl: json['searchUrl'],
    );
  }
}