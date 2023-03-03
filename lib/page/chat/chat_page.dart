import 'dart:convert' as convert;

import 'package:chatgpt_app/manager/cache_manager.dart';
import 'package:chatgpt_app/page/bean/history_bean.dart';
import 'package:chatgpt_app/page/chat/chat_receive_item.dart';
import 'package:chatgpt_app/page/chat/chat_send_item.dart';
import 'package:chatgpt_app/utils/chat_util.dart';
import 'package:chatgpt_app/utils/net_util.dart';
import 'package:chatgpt_app/utils/toast_util.dart';
import 'package:flutter/material.dart';

import '../bean/chatgpt_entity.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/13 10:46
/// @Email gstory0404@gmail.com
/// @Description: 聊天界面

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _inputController = TextEditingController();
  final _listController = ScrollController();

  List<HistoryBean> historyList = [];

  //是否请求中
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> sendMsg() async {
    if (CacheManager.instance.getChatGptKey()?.isEmpty ?? true) {
      ToastUtil.showError(context, "请先设置ChatGPT key");
      return;
    }
    var text = _inputController.value.text;
    if (text.isEmpty) {
      ToastUtil.showError(context, "发送信息不能为空");
      return;
    }
    if (mounted) {
      setState(() {
        isLoading = true;
        historyList.insert(
            0,
            HistoryBean(
                date: DateTime.now().millisecondsSinceEpoch,
                message: Message(role: "user", content: text)));
        _inputController.clear();
      });
    }
    _listController.animateTo(0.0,
        duration: const Duration(milliseconds: 1000), curve: Curves.ease);
    List<Message> messages = [];
    for (int i = 0; i < historyList.length; i++) {
      print("事件戳===》${historyList[i].date}");
      if (messages.length < 7) {
        messages.insert(0, historyList[i].message);
      } else {
        break;
      }
    }
    NetUtils.sendMessage(messages, (value) {
      ChatgptEntity entity =
          ChatgptEntity.fromJson(convert.jsonDecode(value.toString()));
      isLoading = false;
      print(entity.toJson());
      if (entity.error != null) {
        if (entity.error?.code == "429") {
          ToastUtil.showError(context, "请求过于频繁，请稍后再试");
        } else {
          ToastUtil.showError(
              context, "${entity.error?.code} ${entity.error?.message}");
        }
      } else {
        if (mounted) {
          setState(() {
            historyList.insert(
                0,
                HistoryBean(
                    date: DateTime.now().millisecondsSinceEpoch,
                    message: entity.choices!.first.message!));
          });
        }
        _listController.animateTo(0.0,
            duration: const Duration(milliseconds: 1000), curve: Curves.ease);
      }
    }, (error) {
      print(error);
      isLoading = false;
      ToastUtil.showError(context, error);
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: historyList.length,
                reverse: true,
                controller: _listController,
                itemBuilder: (BuildContext context, int index) {
                  if (historyList[index].message.role == "user") {
                    return ChatSendItem(historyList[index]);
                  } else if (historyList[index].message.role == "assistant") {
                    return ChatReceiveItem(historyList[index]);
                  } else if (historyList[index].message.role == "system") {}
                },
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.black12,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      maxLines: 5,
                      minLines: 1,
                      controller: _inputController,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        hintText: '请输入发送信息',
                        border: InputBorder.none,
                      ),
                      cursorWidth: 2.0,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: sendMsg,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal.shade50,
                    elevation: 1,
                    minimumSize: const Size(0, 40),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    side: BorderSide(color: Colors.teal.shade50, width: 1),
                  ),
                  child: const Text(
                    "发送",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
