import 'package:flutter/material.dart';
import 'package:my_flutter_trip/home_widget/webView.dart';
import 'package:my_flutter_trip/model/home_commen_model.dart';

class subNav extends StatelessWidget {
  final List<homeCommonModel> subNavList;
  const subNav({Key key, this.subNavList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child:_items(context,subNavList),
      ),
    );
  }
 _items(BuildContext context, List<homeCommonModel>subNavList){
    List<Widget> items = [];
    if(subNavList==null)return null;
    int lineNum =  ((subNavList.length)/2 + 0.5).toInt() ;

    subNavList.forEach((model) {
      items.add(_item(context, model));
    });
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0,lineNum),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(lineNum,subNavList.length),
        ),
      ],
    );
  }
  _item(BuildContext context, homeCommonModel commonModel){
    return Expanded(
      //平分父组件的大小
      flex: 1,
      child:_wrapGesture(context, Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Image.network(commonModel.icon,width: 18,height: 18,),
            Padding(padding: EdgeInsets.only(top: 3),
              child: Text(commonModel.title,style: TextStyle(color: Colors.black,fontSize: 12),),
            ),
          ],
        ),
      ), commonModel),
    );
  }

  _wrapGesture(BuildContext context ,Widget widget,homeCommonModel commonModel){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:(context)=>webView(
          url: commonModel.url,
          statusBarColor: commonModel.statusBarColor,
          hideAppBar: commonModel.hideAppBar,
        )));
      },
      child: widget,
    );
  }
}
