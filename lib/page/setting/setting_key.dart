import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../lang/strings.dart';
import '../../manager/sp_manager.dart';
import '../../utils/toast_util.dart';

/// @Author: gstory
/// @CreateDate: 2023/3/17 14:55
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SettingKey extends AlertDialog{
  TextEditingController inputController = TextEditingController();

  @override
  Widget? get content {
    return TextField(
      controller: inputController,
      maxLines: 1,
    );
  }

  @override
  List<Widget>? get actions {
    return  [
      TextButton(
        child: Text(Strings.cancel.tr),
        onPressed: () {
          Get.back();
        },
      ),
      TextButton(
          child: Text(Strings.submit.tr),
          onPressed: () {
            var key = inputController.value.text;
            if (key.isEmpty) {
              ToastUtil.showError(Strings.setKeyTip);
              return;
            }
            SPManager.instance.saveChatGptKey(key);
            Get.back();
          }),
    ];
  }
}
