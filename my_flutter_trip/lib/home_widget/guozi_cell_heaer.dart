import 'package:flutter/material.dart';

class homeCellHeader extends StatefulWidget {
  final String title;
  final bool hildRight;
  final Function() rightClickBack;
  const homeCellHeader({Key key, this.title, this.hildRight, this.rightClickBack}) : super(key: key);

  @override
  _homeCellHeaderState createState() => _homeCellHeaderState();
}

class _homeCellHeaderState extends State<homeCellHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 5),
                  decoration:
                  BoxDecoration(color: Color(int.parse('0xfffe5e5e'))),
                  width: 5,
                  height: 20,
                ),
                Text(
                  widget.title??'',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _wrapeTap(context, Container(
            child: Row(
              children: <Widget>[
                Text(
                  '更多',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
                Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 20,)
              ],
            ),
          )),

        ],
      ),
    );
  }

  _wrapeTap(BuildContext context,Widget children){

    return GestureDetector(
      onTap: (){
        if(widget.rightClickBack != null)
          {
            widget.rightClickBack();
          }
      },
      child: children,
    );
  }
}
