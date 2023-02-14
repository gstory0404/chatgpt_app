import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/cupertino.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/13 12:21
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ToastUtil {
  /// 显示错误提示
  static showError(BuildContext context, String msg) {
    CherryToast.error(
      title: Text(msg),
      animationType: AnimationType.fromTop,
      autoDismiss: true,
    ).show(context);
  }
}
