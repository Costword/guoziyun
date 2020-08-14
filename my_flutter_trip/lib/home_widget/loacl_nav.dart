import 'package:flutter/material.dart';
import 'package:my_flutter_trip/home_widget/webView.dart';
import 'package:my_flutter_trip/model/home_commen_model.dart';

class localNav extends StatelessWidget {

  final List<homeCommonModel> localnavList;
  const localNav({Key key,@required this.localnavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(6))),
      height: 64,
      child: Padding(
        padding: EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceAround,//平均分割
          children: _items(context),
        ),
      ),
    );
  }

  _items(BuildContext context){
    if(localnavList == null){
      return null;
    }else{
      List <Widget>items = [];
     localnavList.forEach((model) {
       items.add(item(context,model));
     });
     return items;
    }
  }
  Widget item(BuildContext context,homeCommonModel commonmodel){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => webView(title: commonmodel.title,url: commonmodel.url,hideAppBar: commonmodel.hideAppBar,statusBarColor: commonmodel.statusBarColor,)));
      },
      child: Column(
        children: <Widget>[
          Image.network(commonmodel.icon,width: 32,height:32,),
          Text(commonmodel.title,style: TextStyle(fontSize: 12),)
        ],
      ),
    );
  }
}


