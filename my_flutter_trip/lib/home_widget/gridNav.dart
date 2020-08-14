import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_trip/home_widget/webView.dart';
import 'package:my_flutter_trip/model/home_commen_model.dart';
import 'package:my_flutter_trip/model/home_gridNav.dart';


class GridNav extends StatelessWidget {
  final homeGridNavModel gradeModel;
  const GridNav({Key key,@required this.gradeModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      //切圆角
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,//裁切样式
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: _gridNavItems(context),
        ),
      ),
    );
  }
  _gridNavItems(BuildContext context){
    List<Widget> items = [];
    if(gradeModel == null)
     {
      return items;
    }else
      {
        if(gradeModel.hotel != null)
        {
          items.add(_gradeNavItem(context, gradeModel.hotel, true));
        }
        if(gradeModel.flight != null)
        {
          items.add(_gradeNavItem(context, gradeModel.flight, true));
        }
        if(gradeModel.travel != null)
        {
          items.add(_gradeNavItem(context, gradeModel.travel, true));
        }
      }
    return items;
  }

  _gradeNavItem(BuildContext context,homeGridNavItemModel gradeNavItem,bool first){
    List<Widget> items = [];
    items.add(_mainItem(context, gradeNavItem.mainItem));
    items.add(_douleItem(context, gradeNavItem.item1, gradeNavItem.item2));
    items.add(_douleItem(context, gradeNavItem.item3, gradeNavItem.item4));
    List<Widget> expandItems = [];
    items.forEach((item) {
      expandItems.add(Expanded(child: item, flex: 1));
    });
    Color startColor = Color(int.parse('0xff'+gradeNavItem.startColor));
    Color endColor = Color(int.parse('0xff'+gradeNavItem.endColor));
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor,endColor]),
      ),
      height: 88,
      child: Row(
        children: expandItems,
      ),
    );
  }

  _mainItem(BuildContext context,homeCommonModel commonModel){
    return _warGesture(context,
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Image.network(commonModel.icon,width: 120,height: 88,alignment: AlignmentDirectional.bottomEnd,),
            Container(
              margin: EdgeInsets.only(top: 11),
              child: Text(commonModel.title,style: TextStyle(color: Colors.white),),
            )
          ],
        ),
        commonModel);
  }
  _douleItem(BuildContext context,homeCommonModel topModel,homeCommonModel bottomModel){
    return Column(
      children: <Widget>[
        Expanded(
          //高度撑满父布局
            child: _item(context, topModel, true),
        ),
        Expanded(
          child: _item(context, bottomModel, false),
        ),
      ],
    );
  }
  _item(BuildContext context,homeCommonModel item,bool first){
    BorderSide borderSide = BorderSide(width: 0.8,color: Colors.white);
    return _warGesture(context,  FractionallySizedBox(
      //撑满父容器的宽度
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              left: borderSide,
              bottom: first?borderSide:BorderSide.none
          ),
        ),
        child: Center(
          child: Text(item.title,style: TextStyle(color: Colors.white),),
        ),
      ),
    ), item);
  }

  _warGesture(BuildContext context, Widget widget,homeCommonModel commonModel){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:(context)=>webView(
          url: commonModel.url,
          hideAppBar: commonModel.hideAppBar,
          statusBarColor: commonModel.statusBarColor,
        )));
      },
      child: widget,
    );
  }
}
