import 'package:flutter/material.dart';

class inputTextField extends StatefulWidget {
  final bool secrect;
  final String placeHolder;
  final String valueStr;
  final ValueChanged<String> texChange;
  const inputTextField({Key key, this.secrect = false,this.placeHolder,this.valueStr, this.texChange}) : super(key: key);
  @override
  _inputTextFieldState createState() => _inputTextFieldState();
}

class _inputTextFieldState extends State<inputTextField> {
  final TextEditingController _inputController = TextEditingController();
  bool showPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _inputController.text = widget.valueStr;
    });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _inputController.dispose();
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
              obscureText: showPassword,
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
          widget.secrect == true
              ? _wrapTap(
              context,
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  showPassword == true
                      ? Icons.remove_red_eye
                      : Icons.vpn_key,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              _showPasswordOrNO)
              : _wrapTap(
              context,
              Container(
                width: 20,
                height: 20,
                child: null,
              ),
                  () => null),
        ],
      ),
    );
  }

  //输入监听
  _inputOnChange(String tex) {
    if(widget.texChange !=null){
      widget.texChange(tex);
    }
  }

  _wrapTap(BuildContext context, Widget widget, Function() tap) {
    return GestureDetector(
      onTap: tap,
      child: widget,
    );
  }
  //是否显示密码
  _showPasswordOrNO() {
    setState(() {
      showPassword = !showPassword;
    });
  }
}
