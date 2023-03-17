import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../lang/strings.dart';
import '../../manager/sp_manager.dart';
import '../../utils/toast_util.dart';

/// @Author: gstory
/// @CreateDate: 2023/3/17 16:04
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SettingKeyDialog extends StatefulWidget {
  const SettingKeyDialog({Key? key}) : super(key: key);

  @override
  State<SettingKeyDialog> createState() => _SettingKeyDialogState();
}

class _SettingKeyDialogState extends State<SettingKeyDialog> {
  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    inputController.text = SPManager.instance.getChatGptKey() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Strings.setKey.tr,
            style: TextStyle(fontSize: 20),
          ),
          TextField(
            controller: inputController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text(Strings.cancel.tr),
                onPressed: () {
                  Navigator.of(context).pop('cancel');
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
                  Navigator.of(context).pop('ok');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
