import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const List CATCH_URLS = ['m.ctrip.com/','m.ctrip.com/html5/','m.ctrip.com/html5'];//白名单用于判断返回事件

class webView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;
  webView({this.url, this.statusBarColor, this.title, this.hideAppBar, this.backForbid=false});
  @override
  _webViewState createState() => _webViewState();
}

class _webViewState extends State<webView> {

  final flutterWebViewPlugin = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterWebViewPlugin.close();
    flutterWebViewPlugin.onUrlChanged.listen((String url) {});
    flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          if(_isToMain(state.url))
           {
             if(widget.backForbid)
               {
                 flutterWebViewPlugin.launch(widget.url);
               }else
                 {
                   Navigator.pop(context);
                 }
          }
          break;
        default:
          break;
      }
    });
    flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {});
  }

  _isToMain(String url)
  {
    bool contain = false;
    for(final value in CATCH_URLS)
   {
      if(url.endsWith(value)??false)
        {
          contain = true;
          break;
        }
    }
  return contain;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    flutterWebViewPlugin.dispose();
  }


  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff'+statusBarColorStr)), Colors.white),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withZoom: true,
              //缩放
              withLocalStorage: true,
              //开启本地缓存
              hidden: true,
              //加载过程中是否隐藏
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Text('加载中...'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color BackButtonColorl) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    } else {
      return Container(
        color: backgroundColor,
        padding: EdgeInsets.fromLTRB(0,40, 0,10),
        child: FractionallySizedBox(
          widthFactor: 1,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.close,
                    color: BackButtonColorl,
                    size: 26,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    widget.title ?? '',
                    style: TextStyle(fontSize: 16, color: BackButtonColorl),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

