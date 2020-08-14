import 'package:flutter/material.dart';

class statefulWrapTapButton extends StatefulWidget {
  final String text;
  final bool canTap;
  final Color normalColor;
  final Color disableColor;
  final Function() TapBack;
  const statefulWrapTapButton({Key key, this.text='', this.canTap = false,this.normalColor =Colors.white,this.disableColor = Colors.grey ,this.TapBack}) : super(key: key);
@override
  _statefulWrapTapButtonState createState() => _statefulWrapTapButtonState();
}

class _statefulWrapTapButtonState extends State<statefulWrapTapButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(widget.TapBack!= null){
          if(widget.canTap==true){
            widget.TapBack();
          }
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        margin: EdgeInsets.fromLTRB(30, 5, 30, 5),
        decoration: BoxDecoration(
          color: widget.canTap==true?widget.normalColor:widget.disableColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  widget.text,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
