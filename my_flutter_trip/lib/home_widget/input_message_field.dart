import 'dart:async';
import 'package:flutter/material.dart';

class inputMessageField extends StatefulWidget {
  final String placeHolder;
  final Function() getMessage;
  final ValueChanged<String> messageChange;

  const inputMessageField({Key key,this.placeHolder='输入验证码', this.getMessage, this.messageChange}) : super(key: key);
  @override
  _inputMessageFieldState createState() => _inputMessageFieldState();
}

class _inputMessageFieldState extends State<inputMessageField> {

  final TextEditingController _inputController = TextEditingController();
  bool canTap = false;
  String daojishi = '重新获取';
  Timer _countDownTimer;

  @override
  void initState() {
    // TODO: implement initState
    _daojishi();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _countDownTimer?.cancel();
    _countDownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _inputField(widget.placeHolder);
  }

  _inputField(String placeHolder) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color(int.parse('0xfff2f2f2')),
        borderRadius: BorderRadius.circular(25),

      ),
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: TextField(
              controller: _inputController,
              onChanged: (text) {
                _inputOnChange(text);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeHolder ?? '哈哈哈',
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
                contentPadding:
                EdgeInsets.only(left: 20, right: 10, bottom:0),
              ),
            ),
          ),
          _wrapTap(
              context,
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(daojishi,style: TextStyle(color: canTap==true?Colors.black:Colors.grey,fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              _getMessageClick),

        ],
      ),
    );
  }

  //输入监听
  _inputOnChange(String tex) {
    if(widget.messageChange !=null){
      widget.messageChange(tex);
    }
  }

  _wrapTap(BuildContext context, Widget widget, Function() tap) {
    return GestureDetector(
      onTap: tap,
      child: widget,
    );
  }
  //是否显示密码
  _getMessageClick() {
    if(canTap==true){
      _daojishi();
      if(widget.getMessage!=null){
        widget.getMessage();
      }
    }
  }

  _daojishi() {
    int seconds = 59;
    _countDownTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        seconds--;
        if(seconds>0){
          canTap=false;
          daojishi = '重新获取（${seconds}）';
        }else
          {
            canTap=true;
            daojishi = '重新获取';
            _countDownTimer.cancel();
            _countDownTimer = null;
          }
      });

    });
  }
}
