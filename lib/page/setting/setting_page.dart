import 'dart:io';

import 'package:chatgpt_app/lang/strings.dart';
import 'package:chatgpt_app/manager/sp_manager.dart';
import 'package:chatgpt_app/page/setting/setting_key.dart';
import 'package:chatgpt_app/page/setting/setting_key_dialog.dart';
import 'package:chatgpt_app/page/setting/setting_language_dialog.dart';
import 'package:chatgpt_app/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:url_launcher/url_launcher.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/14 09:26
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (Platform.isAndroid || Platform.isIOS)
          ? AppBar(
              title: Text(Strings.setting.tr),
              centerTitle: true,
            )
          : null,
      body: Container(
        child: Column(
          children: [
            //设置 key
            ListTile(
              title: Text(
                Strings.setKey.tr,
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // _showSetting(context);
                Get.dialog(const AlertDialog(
                  content: SettingKeyDialog(),
                ));
              },
            ),
            Container(
              height: 1,
              color: Colors.black12,
            ),
            //设置语言
            ListTile(
              title: Text(
                Strings.language.tr,
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Get.dialog(const AlertDialog(
                  content: SettingLanguageDialog(),
                ));
              },
            ),
            //关于app
            Container(
              height: 1,
              color: Colors.black12,
            ),
            ListTile(
              title: Text(
                Strings.aboutApp.tr,
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _showAbout(context);
              },
            )
          ],
        ),
      ),
    );
  }

  ///显示设置key
  _showSetting(BuildContext context) {
    TextEditingController inputController = TextEditingController();
    inputController.text = SPManager.instance.getChatGptKey() ?? "";
    //设置对话框
    AlertDialog alert = AlertDialog(
      title: Text(Strings.setKey.tr),
      content: TextField(
        controller: inputController,
      ),
      actions: [
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
            }),
      ],
    );
    //显示对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  ///显示关于
  _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'ChatGPT APP',
      applicationIcon:
          Image.asset("assets/images/logo.png", width: 80, height: 80),
      applicationVersion: '1.0.0',
      applicationLegalese: 'copyright @ gstory',
      useRootNavigator: true,
      children: [
        Container(height: 20),
        ListTile(
          leading: const Icon(Icons.label_important_outline),
          title: Text(Strings.appHome.tr),
          trailing: const Icon(Icons.keyboard_arrow_right),
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          onTap: () async {
            await launchUrl(
                Uri.parse("https://github.com/gstory0404/chatgpt_app"));
          },
        ),
        ListTile(
          leading: const Icon(Icons.label_important_outline),
          title: Text(Strings.appPact.tr),
          trailing: const Icon(Icons.keyboard_arrow_right),
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          onTap: () async {
            await launchUrl(Uri.parse(
                "https://github.com/gstory0404/chatgpt_app/blob/master/LICENSE"));
          },
        ),
      ],
    );
  }
}
