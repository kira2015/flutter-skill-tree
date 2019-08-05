 
 ### 自适应文本
 auto_size_text: ^2.0.2

 import 'package:auto_size_text/auto_size_text.dart';


#单个自适应text
\\
    AutoSizeText(
    "A really long String",
    style: TextStyle(fontSize: 40),
    minFontSize: 10,
    stepGranularity: 10,
    maxLines: 4,
    overflow: TextOverflow.ellipsis,
    )
\\
、、、   
    自选从大到小的字号 
    presetFontSizes: [40, 20, 14],

    字过长的代替：
    overflowReplacement:
、、、
#多个
\\
    var myGroup = AutoSizeGroup();
    AutoSizeText(
    "Text 1",
    group: myGroup,
    );

    AutoSizeText(
    "Text 2",
    group: myGroup,
    );
\\


### 自定义键盘 （切换键盘，增加自定义按钮在上方）
keyboard_actions: "^2.1.1"
import  'package:keyboard_actions/keyboard_actions.dart';

##配置 _buildConfig(context)方法
、、、
    final FocusNode _nodeText1 = FocusNode();
    final FocusNode _nodeText2 = FocusNode();

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
                child: Icon(Icons.close),
            ),
            ),
        ]);}
、、、
##初始化
 @override
  void initState() {
    FormKeyboardActions.setKeyboardActions(context, _buildConfig(context));
    super.initState();
  }

  ##使用  focusNode: _nodeText1,
、、、
    TextField(
        keyboardType: TextInputType.number,
        focusNode: _nodeText1,
        decoration: InputDecoration(
        hintText: "Input Number",
        ),
            ),
、、、
