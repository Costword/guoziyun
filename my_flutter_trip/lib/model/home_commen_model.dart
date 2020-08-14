

//"icon":"https://www.devio.org/io/flutter_app/img/ln_weekend.png",
//"title":"周边游",
//"url":"https://m.ctrip.com/webapp/vacations/tour/around?&amp;from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F",
//"statusBarColor":"52149f",
//"hideAppBar":true

class homeCommonModel{
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  homeCommonModel({this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory homeCommonModel.fromJson(Map<String,dynamic>json){
    return homeCommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }

  Map<String,dynamic>toJson (){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['url'] = this.url;
    data['statusBarColor'] = this.statusBarColor;
    data['hideAppBar'] = this.hideAppBar;
    return data;
  }
}