import 'dart:io';

import 'package:chatgpt_app/manager/cache_manager.dart';
import 'package:chatgpt_app/utils/toast_util.dart';
import 'package:flutter/material.dart';
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
              title: Text("设置"),
              centerTitle: true,
            )
          : null,
      body: Container(
        child: Column(
          children: [
            ListTile(
              title: Text(
                '设置',
                style: TextStyle(fontSize: 16),
              ),
              subtitle: Text(
                '设置openai keys',
                style: TextStyle(fontSize: 10),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _showSetting(context);
              },
            ),
            Container(
              height: 1,
              color: Colors.black12,
            ),
            ListTile(
              title: Text(
                '关于APP',
                style: TextStyle(fontSize: 16),
              ),
              subtitle: Text(
                'App主页、开源协议等',
                style: TextStyle(fontSize: 10),
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
    inputController.text = CacheManager.instance.getChatGptKey() ?? "";
    //设置对话框
    AlertDialog alert = AlertDialog(
      title: const Text("设置chatgpt key"),
      content: TextField(
        controller: inputController,
      ),
      actions: [
        TextButton(
          child: const Text("取消"),
          onPressed: () {
            Navigator.of(context).pop('cancel');
          },
        ),
        TextButton(
            child: const Text("确定"),
            onPressed: () {
              var key = inputController.value.text;
              if (key.isEmpty) {
                ToastUtil.showError(context, "请输入ChatGPT key");
                return;
              }
              CacheManager.instance.saveChatGptKey(key);
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
          title: const Text('开源主页'),
          trailing: const Icon(Icons.keyboard_arrow_right),
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          onTap: () async {
            await launchUrl(
                Uri.parse("https://github.com/gstory0404/chatgpt_app"));
          },
        ),
        ListTile(
          leading: const Icon(Icons.label_important_outline),
          title: const Text('开源协议'),
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
