import 'package:chatgpt_app/lang/strings.dart';
import 'package:chatgpt_app/manager/sp_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/global_keys.dart';
import '../../utils/language_util.dart';

/// @Author: gstory
/// @CreateDate: 2023/3/17 15:16
/// @Email gstory0404@gmail.com
/// @Description: 设置语言

class SettingLanguageDialog extends StatefulWidget {
  const SettingLanguageDialog({Key? key}) : super(key: key);

  @override
  State<SettingLanguageDialog> createState() => _SettingLanguageState();
}

class _SettingLanguageState extends State<SettingLanguageDialog> {
  late String lan;

  @override
  void initState() {
    super.initState();
    lan = LanguageUtil.getLanguage();
    print("lan===》$lan");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(Strings.language.tr,style: const TextStyle(fontSize: 20),),
        //中文
        RadioListTile(
          value: LanguageKey.zh,
          onChanged: <String>(value) {
            setState(() {
              lan = value;
            });
          },
          groupValue: lan,
          title: Text(Strings.chinese.tr),
          selected: lan == LanguageKey.zh,
        ),
        //英文
        RadioListTile(
          value: LanguageKey.en,
          onChanged: <String>(value) {
            setState(() {
              lan = value;
            });
          },
          groupValue: lan,
          title: Text(Strings.english.tr),
          selected: lan == LanguageKey.en,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text(Strings.cancel.tr),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text(Strings.submit.tr),
              onPressed: () {
                LanguageUtil.setLanguage(lan);
                Get.back();
              },
            ),
          ],
        )
      ],
    );
  }
}
