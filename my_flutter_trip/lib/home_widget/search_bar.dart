import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SearchBarType { home, normal, hlight }

class searchBar extends StatefulWidget {
  final bool enabled;
  final bool hildleft;
  final SearchBarType searchBarType;
  final String hint; //placeHolder
  final String defoutTex; //默认文案
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speakClick;
  final void Function() inputBoxClick;
  final ValueChanged<String> onChanged;

  const searchBar(
      {Key key,
      this.enabled = false,
      this.hildleft,
      this.searchBarType = SearchBarType.normal,
      this.hint = '哈哈',
      this.defoutTex = '你猜我猜不猜',
      this.leftButtonClick,
      this.rightButtonClick,
      this.speakClick,
      this.inputBoxClick,
      this.onChanged})
      : super(key: key);

  @override
  _searchBarState createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  bool showClear = false;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.defoutTex != null) {
      setState(() {
        _textEditingController.text = widget.defoutTex;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _normalSearch();
  }

  _normalSearch() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      height: 30,
      child: Row(
        children: <Widget>[
          _wrpeTap(
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: widget?.hildleft ?? false
                    ? null
                    : Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                        size: 20,
                      ),
              ),
              widget.leftButtonClick),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrpeTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  '搜索',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ),
              widget.rightButtonClick),
        ],
      ),
    );
  }

  _wrpeTap(Widget child, void Function() callBack) {
    return GestureDetector(
      onTap: callBack,
      child: child,
    );
  }

  _inputBox() {
    Color inputColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputColor = Colors.white;
    } else {
      inputColor = Color(int.parse('0xffEDEDED'));
    }
    return Container(
      decoration: BoxDecoration(
        color: Color(int.parse('0xffEDEDED')),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal
                ? Color(int.parse('0xffA9A9A9'))
                : Colors.blue,
          ),
          Expanded(
            flex: 1,
            child: widget.searchBarType == SearchBarType.normal
                ? TextField(
                controller: _textEditingController,
                onChanged: _onChanged,
                autofocus: true,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
                //输入文本的样式
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 5,right: 5,bottom: 12),
                  border: InputBorder.none,
                  hintText: widget.hint ?? '',
                  hintStyle: TextStyle(fontSize: 15),
                ))
                : _wrpeTap(
                Container(
                  child: Text(
                    widget.defoutTex,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
                widget.inputBoxClick),
          ),
        ],
      ),
    );
  }

  _onChanged(String text) {
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }
}
