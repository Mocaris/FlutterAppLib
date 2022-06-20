import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class KeyboardUtil {
  /// 拷贝文本内容到剪切板
  static Future<void> copy2Clip(String data) async {
    if (data.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: data));
    }
  }

  ///不要放在app顶层
  static void hideKeyboardUnFocus(BuildContext context) {
    var scopeNode = FocusScope.of(context);
    if (!scopeNode.hasPrimaryFocus && null != scopeNode.focusedChild) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  /// 隐藏软键盘，具体可看：TextInputChannel
  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  /// 展示软键盘，具体可看：TextInputChannel
  static void showKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  /// 清除数据
  static void clearClientKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.clearClient');
  }
}
