import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../lang/strings.dart';
import '../../manager/sp_manager.dart';
import '../../utils/toast_util.dart';

/// @Author: gstory
/// @CreateDate: 2023/3/17 16:04
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SettingChatGPTDialog extends StatefulWidget {
  const SettingChatGPTDialog({Key? key}) : super(key: key);

  @override
  State<SettingChatGPTDialog> createState() => _SettingKeyDialogState();
}

class _SettingKeyDialogState extends State<SettingChatGPTDialog> {
  TextEditingController keyController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController contextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    keyController.text = SPManager.instance.getChatGptKey();
    sizeController.text = "${SPManager.instance.getChatMaxToken()}";
    contextController.text = "${SPManager.instance.getChatMaxContext()}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //key
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Strings.setKey.tr,
                style: const TextStyle(fontSize: 16),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: keyController,
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: Strings.setKeyTip.tr,
                        hintStyle: TextStyle(fontSize: 14)),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(vertical: 10),
            color: Colors.black12,
          ),
          //字符数
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Strings.setMaxSize.tr,
                style: const TextStyle(fontSize: 16),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: sizeController,
                    textAlign: TextAlign.end,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly //只允许输入数字
                    ],
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: Strings.setMaxSizeTip.tr,
                        hintStyle: TextStyle(fontSize: 14)),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(vertical: 10),
            color: Colors.black12,
          ),
          //上下文关联数
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Strings.setMaxContent.tr,
                style: const TextStyle(fontSize: 16),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: contextController,
                    textAlign: TextAlign.end,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly //只允许输入数字
                    ],
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: Strings.setMaxContentTip.tr,
                        hintStyle: TextStyle(fontSize: 14)),
                  ),
                ),
              ),
            ],
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
                  //字符空
                  var key = keyController.value.text;
                  if (key.isEmpty) {
                    ToastUtil.showError(Strings.setKeyTip.tr);
                    return;
                  }
                  //字符数空
                  if (sizeController.value.text.isEmpty) {
                    ToastUtil.showError(Strings.setKeyTip.tr);
                    return;
                  }
                  var token = int.parse(sizeController.value.text);
                  if (token == 0) {
                    ToastUtil.showError(Strings.setKeyTip.tr);
                    return;
                  }
                  //上下文关联空
                  if (contextController.value.text.isEmpty) {
                    ToastUtil.showError(Strings.setKeyTip.tr);
                    return;
                  }
                  var con = int.parse(contextController.value.text);
                  if (con == 0) {
                    ToastUtil.showError(Strings.setKeyTip.tr);
                    return;
                  }
                  SPManager.instance.saveChatGptKey(key);
                  SPManager.instance.saveGptMaxToken(token);
                  SPManager.instance.saveChatMaxContext(con);
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
