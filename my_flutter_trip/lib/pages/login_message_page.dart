import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_flutter_trip/home_widget/input_message_field.dart';
import 'package:my_flutter_trip/home_widget/login_state_button.dart';
import 'package:my_flutter_trip/network/m_networking.dart';
import 'package:my_flutter_trip/urls/my_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class messageLoginPage extends StatefulWidget {
  final String phoneNum;
  const messageLoginPage({Key key,@required this.phoneNum=''}) : super(key: key);
  @override
  _messageLoginPageState createState() => _messageLoginPageState();
}

class _messageLoginPageState extends State<messageLoginPage> {


  bool canLogin = false;
  static Color normalColor = Color(int.parse('0xffff5e5e'));
  static Color disableColor = normalColor.withOpacity(0.5);
  String _messageCode = '';
  MyUrlsWidget urlsWidget = MyUrlsWidget();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 40,left: 15),
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 20,),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 30, left: 30, bottom: 30),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '输入验证码',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '已发送 6位 验证码至 ${widget.phoneNum}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          wordSpacing: 5),
                    ),
                  ],
                ),
              ],
            ),
          ),
          inputMessageField(messageChange:_messageChange,getMessage: _getMessage,),
          statefulWrapTapButton(text: '确定',canTap:canLogin,normalColor: normalColor,disableColor: disableColor,TapBack: _loginWithMessage,),
        ],
      ),
    );
  }


  _getMessage ()async{
    if(widget.phoneNum.length==0)return;
    Map<String,dynamic> params = {};
    params['phone'] = widget.phoneNum;
    var result = await m_postUrlWithParams(urlsWidget.sendMessage, params);
    var josnData  = json.decode(result.toString());
    int code = josnData['code'];
    String msg = josnData['msg'];
    if(code==200){
      print('发送验证码成功');


    }else
    {
      print('发送失败：$msg');
    }
  }

  _messageChange(String message){
    setState(() {
      _messageCode = message;
      if(message.length>0){
        canLogin = true;
      }else{
        canLogin = false;
      }
    });
  }
  _loginWithMessage()async{

    Map<String,dynamic> params = {};
    params['phone'] = widget.phoneNum;
    params['code'] = _messageCode;
    params['system'] = 'ios';

    var result = await m_postUrlWithParams(urlsWidget.loginMessage, params);
    var josnData  = json.decode(result.toString());
    int code = josnData['code'];
    String msg = josnData['msg'];

    if(code==200){
      print('登录成功');
      String userid = josnData['data']['user_id'];
      final SharedPreferences prefs = await _prefs;
      prefs.setString('user_id', userid);
    }else
    {
      print('登录失败：$msg');
    }
  }

}
