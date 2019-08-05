import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class AutoTextHome extends StatefulWidget {
  @override
  _AutoTextHomeState createState() => _AutoTextHomeState();
}

class _AutoTextHomeState extends State<AutoTextHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('自动缩放的文本'),
      ),
      body: FormKeyboardActions(
        autoScroll: true,
        child: ContentWidget(),
      ),
    );
  }
}

class ContentWidget extends StatefulWidget {
  @override
  _ContentWidgetState createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  TextEditingController textEditingController;
  String tt = '';
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  @override
  void initState() {
    textEditingController = TextEditingController();
    FormKeyboardActions.setKeyboardActions(context, _buildConfig(context));
    super.initState();
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _nodeText1,
        ),
        KeyboardAction(
          focusNode: _nodeText2,
          closeWidget: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('自定义按钮'),
          ),
          onTapAction: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("自定义按钮 Action"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  );
                });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //输入框
          Container(
            margin: EdgeInsets.only(bottom: 15),
            color: Colors.grey,
            child: SizedBox(
              child: TextField(
                focusNode: _nodeText1,
                controller: textEditingController,
                maxLength: 100,
                minLines: 1,
                maxLines: 10,
                onChanged: (t) {
                  setState(() {
                    tt = t;
                  });
                },
              ),
            ),
          ),

          Text('AutoSizeText------'),
          Align(
            alignment: Alignment(0, 0),
            child: Container(
              width: 200,
              height: 100,
              margin: EdgeInsets.only(bottom: 20),
              color: Colors.pink[100],
              child: AutoSizeText(
                tt,
                // minFontSize: 5,
                // maxFontSize: 34,
                maxLines: 3,
                presetFontSizes: [30, 20, 10], //备选fontsize 从左到右选择最合适的显示
              ),
            ),
          ),

          Text('AutoSizeText.rich------'),
          Container(
            height: 100,
            color: Colors.purple,
            child: Align(
              alignment: Alignment(0, 0),
              child: AutoSizeText.rich(
                TextSpan(
                  text: '基础text',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  children: [
                    TextSpan(
                      text: '第一段内容',
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                    TextSpan(
                      text: '第二段内容',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: '第@@1段内容黄色',
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                        TextSpan(
                          text: '第@@2段内容黄色',
                        ),
                      ],
                    ),
                    TextSpan(
                      text: '第三段内容',
                    ),
                  ],
                ),
                minFontSize: 5,
                maxLines: 2,
                maxFontSize: 12,
              ),
            ),
          ),


          Padding(
            
            padding: const EdgeInsets.only(top: 20,bottom: 10),
            child: Text('自定义键盘------'),
          ),
          //输入框
          Container(
            color: Colors.teal[100],
            child: SizedBox(
              child: TextField(
                focusNode: _nodeText2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
