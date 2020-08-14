import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_flutter_trip/home_widget/input_field.dart';
import 'package:my_flutter_trip/home_widget/login_state_button.dart';
import 'package:my_flutter_trip/network/m_networking.dart';
import 'package:my_flutter_trip/urls/my_urls.dart';

import 'login_message_page.dart';

enum ThirdLoginType {
  QQLogin,
  WeiXinLogin,
}

class myLoginPage extends StatefulWidget {
  @override
  _myLoginPageState createState() => _myLoginPageState();
}

class _myLoginPageState extends State<myLoginPage> {
  bool passwordLoginType = true;
  bool canLogin = false;
  ThirdLoginType loginType = ThirdLoginType.QQLogin;
  String loginTypeStr = '验证码登录';
  String _account = '';
  String _passWord = '';
  static Color normalColor = Color(int.parse('0xffff5e5e'));
  static Color disableColor = normalColor.withOpacity(0.5);
  MyUrlsWidget urlsWidget = MyUrlsWidget();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image.asset('images/login_bg@3x.png',width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),)
            ],
          ),
          Column(
            children: <Widget>[
              _wrapTap(
                  context,
                  Container(
                    margin: EdgeInsets.only(top: 30, right: 10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      loginTypeStr,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                  ),
                  _changeLoginType),
              passwordLoginType == true
                  ? _passwordLoginPage()
                  : _messageLoginPage(),
            ],
          ),
        ],
      )
    );
  }

  _passwordLoginPage() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 30, left: 30, bottom: 30),
            child: Text(
              '密码登录',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
          ),
          inputTextField(
            secrect: false,
            placeHolder: '请输入手机号',
            valueStr: _account,
            texChange: _accountChange,
          ),
          inputTextField(
            secrect: true,
            placeHolder: '请输入验证码',
            valueStr: _passWord,
            texChange: _passwordChange,
          ),
          statefulWrapTapButton(text: '登录',canTap:canLogin,normalColor: normalColor,disableColor: disableColor,TapBack: _loginClick,),
        ],
      ),
    );
  }

  _messageLoginPage() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 30, left: 30, bottom: 30),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: '欢迎登录/注册',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: '国字云',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '弘扬传统文化，写好中国字',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 19,
                          fontWeight: FontWeight.w300,
                          wordSpacing: 5),
                    ),
                  ],
                ),
              ],
            ),
          ),
          inputTextField(
            secrect: false,
            placeHolder: '请输入手机号',
            valueStr: _account,
            texChange: _accountChange,
          ),
          statefulWrapTapButton(text: '获取验证码',canTap:canLogin,normalColor: normalColor,disableColor: disableColor,TapBack: _getMessage,),
        ],
      ),
    );
  }

  _wrapTap(BuildContext context, Widget widget, Function() tap) {
    return GestureDetector(
      onTap: tap,
      child: widget,
    );
  }

  //切换登录方式
  _changeLoginType() {
    if (passwordLoginType == true) {
      passwordLoginType = false;
      setState(() {
        loginTypeStr = '密码登录';
      });
    } else {
      passwordLoginType = true;
      setState(() {
        loginTypeStr = '验证码登录';
      });
    }
  }

  //其他登录方式
  _otherLoginType() {}

  //账号改变
  _accountChange(String tex) {
    setState(() {
      _account = tex;
      if(passwordLoginType==true &&(_account.length>0&&_passWord.length>0)){
        canLogin = true;
      }else if(passwordLoginType==false && _account.length>0){
        canLogin = true;
      }else{
        canLogin = false;
      }
    });
  }

  //密码改变
  _passwordChange(String tex) {
    setState(() {
      _passWord = tex;
      if(passwordLoginType==true &&(_account.length>0&&_passWord.length>0)){
        canLogin = true;
      }else{
        canLogin = false;
      }
    });
  }

  //登录
  _loginClick() async{
    Map<String,dynamic> params = {};
    params['phone'] = _account;
    params['password'] = generateMd5(_passWord);
    params['system'] = 'ios';

    var result = await m_postUrlWithParams(urlsWidget.loginPassword, params);
    var josnData  = json.decode(result.toString());
    int code = josnData['code'];
    String msg = josnData['msg'];
    if(code==200){
      print('登录成功');
    }else
      {
        print('登录失败：$msg');
      }
    print(josnData);
  }

  _getMessage ()async{
    if(_account.length==0)return;
    Map<String,dynamic> params = {};
    params['phone'] = _account;
    var result = await m_postUrlWithParams(urlsWidget.sendMessage, params);
    var josnData  = json.decode(result.toString());
    int code = josnData['code'];
    String msg = josnData['msg'];
    if(code==200){
      print('发送验证码成功');
      Navigator.push(context, MaterialPageRoute(builder: (context) => messageLoginPage(
        phoneNum: _account,
      )));
    }else
    {
      print('发送失败：$msg');
    }
  }
}
