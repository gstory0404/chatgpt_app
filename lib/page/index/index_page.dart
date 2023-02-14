import 'package:chatgpt_app/manager/cache_manager.dart';
import 'package:chatgpt_app/page/chat/chat_page.dart';
import 'package:chatgpt_app/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/14 09:11
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  @override
  void initState() {
    super.initState();
    CacheManager.instance.initCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ChatGPT",
          style: TextStyle(fontSize: 16.0, color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
        elevation: 0.5,
        actions: <Widget>[
          PopupMenuButton(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Icon(Icons.settings, color: Colors.black87),
            ),
            onSelected: (object) {;
              if (object == "setting") {
                _showSetting(context);
              } else if (object == "about") {
                _showAbout(context);
              }
            },
            itemBuilder: (context) => [
              _popItem("设置", "setting"),
              _popItem("关于APP", "about"),
            ],
          )
        ],
      ),
      body: const ChatPage(),
    );
  }

  PopupMenuItem _popItem(String title, String value, {VoidCallback? callback}) {
    return PopupMenuItem(
      child: Text(title),
      value: value,
      onTap: callback,
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
        TextButton(child: const Text("确定"), onPressed: () {
          var key = inputController.value.text;
          if(key.isEmpty){
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
            await launchUrl(Uri.parse(
                "https://github.com/gstory0404/fun_reader/blob/master/rule.md"));
          },
        ),
        ListTile(
          leading: const Icon(Icons.label_important_outline),
          title: const Text('开源协议'),
          trailing: const Icon(Icons.keyboard_arrow_right),
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          onTap: () async {
            await launchUrl(Uri.parse(
                "https://github.com/gstory0404/fun_reader/blob/master/rule.md"));
          },
        ),
      ],
    );
  }
}
