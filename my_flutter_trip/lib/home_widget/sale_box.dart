import 'package:flutter/material.dart';
import 'package:my_flutter_trip/model/home_commen_model.dart';
import 'package:my_flutter_trip/model/home_salesBox.dart';

class saleBoxPage extends StatelessWidget {
  final homeSaleBoxModel saleBox;

  const saleBoxPage({Key key, this.saleBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: _saleBox(context, saleBox),
      ),
    );
  }

  _saleBox(BuildContext context, homeSaleBoxModel saleBoxModel) {
    List<Widget> items = [];
    if (saleBoxModel == null) return items;
    items.add(_headerBox(context, saleBoxModel));
    items.add(_doubleItem(
        context, saleBoxModel.bigCard1, saleBoxModel.bigCard2, true, false));
    items.add(_doubleItem(context, saleBoxModel.smallCard1,
        saleBoxModel.smallCard2, false, false));
    items.add(_doubleItem(context, saleBoxModel.smallCard3,
        saleBoxModel.smallCard4, false, true));
    return items;
  }
  _headerBox(BuildContext context,homeSaleBoxModel saleBoxModel){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      border: Border(bottom: BorderSide(width: 1,color: Colors.black12)),
      ),
      margin: EdgeInsets.only(left:10),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(0,10,0,10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.network(saleBoxModel.icon,height: 20,fit: BoxFit.fill,),
            Container(
              alignment:Alignment.centerRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: [
                  Color(0xffff4e63),
                  Color(0xffff6cc9),]),
              ),
              padding:EdgeInsets.fromLTRB(10, 1, 8, 1) ,
              margin: EdgeInsets.only(right: 7),
              child: GestureDetector(
                onTap: (){
                  
                },
                child: Text('更多精彩活动 >',style: TextStyle(color: Colors.white,fontSize: 14),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _doubleItem(BuildContext context, homeCommonModel leftModel,
      homeCommonModel rightModel, bool isBig, bool islast) {
    return Row(
      children: <Widget>[
        _cardItem(context, leftModel, true, isBig, islast),
        _cardItem(context, rightModel, false, isBig, islast),
      ],
    );
  }

  _cardItem(BuildContext context, homeCommonModel itemModel, bool isleft,
      bool isBig, bool islast) {
    BorderSide borderSide = BorderSide(
      color: Colors.black12,
      width: 0.8,
    );
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: isleft == true ? BorderSide.none : borderSide,
            bottom: (isBig == true || islast == true)
                ? BorderSide.none
                : borderSide,
          ),
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            Image.network(
              itemModel.icon,
              width: MediaQuery.of(context).size.width/2-7,
              height: isBig == true ? 128 : 64,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
