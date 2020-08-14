import 'package:flutter/material.dart';

class MyUrlsWidget{
 String loginPassword;//密码登录
 String loginMessage;//验证码登录
 String sendMessage;//发送验证码
 String homeBannerList;
 String homeList;
 MyUrlsWidget({
  this.loginPassword='api/user/loginPass',
  this.loginMessage='api/user/loginCode',
  this.sendMessage = 'api/user/sendVeriCode',
  this.homeBannerList = 'api/activity/lists',
  this.homeList = 'api/coursepackage/homelist',
 });
}