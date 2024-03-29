import 'package:chatgpt_app/manager/sp_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../lang/strings.dart';
import '../../utils/net_util.dart';
import '../../utils/toast_util.dart';
import '../bean/chatgpt_entity.dart';
import '../bean/history_bean.dart';
import 'dart:convert' as convert;

/// @Author: gstory
/// @CreateDate: 2023/3/17 12:28
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ChatCtr extends GetxController {
  final inputController = TextEditingController();
  final listController = ScrollController();

  List<HistoryBean> historyList = [];

  //角色扮演
  String system = "";

  //是否请求中
  bool isLoading = false;

  Future<void> sendMsg() async {
    //检查是否存在key
    if (SPManager.instance.getChatGptKey()?.isEmpty ?? true) {
      ToastUtil.showError(Strings.emptyKey.tr);
      return;
    }
    //检查是否有内容
    var text = inputController.value.text.trim();
    if (text.isEmpty) {
      ToastUtil.showError(Strings.emptyContent.tr);
      return;
    }

    //角色扮演
    if (text.startsWith("@system ")) {
      system = text.replaceFirst("@system ", "");
      inputController.clear();
      update();
      return;
      //清理角色
    } else if (text.startsWith("@exit")) {
      system = "";
      update();
      inputController.clear();
      return;
      //对话
    } else {
      historyList.insert(
          0,
          HistoryBean(
              date: DateTime.now().millisecondsSinceEpoch,
              type: ChatType.CHAT,
              message: Message(role: "user", content: text)));
      inputController.clear();
    }
    listController.animateTo(0.0,
        duration: const Duration(milliseconds: 1000), curve: Curves.ease);
    update();
    List<Message> messages = [];
    for (int i = 0; i < historyList.length; i++) {
      if (historyList[i].type == ChatType.CHAT && messages.length < SPManager.instance.getChatMaxContext()) {
        messages.insert(0, historyList[i].message);
      } else {
        continue;
      }
    }
    if (system.isNotEmpty) {
      messages.insert(0, Message(role: "system", content: system));
    }
    getChat(messages);
  }

  //请求chat
  void getChat(List<Message> messages) {
    isLoading = true;
    NetUtils.sendMessage(messages, (value) {
      ChatgptEntity entity =
          ChatgptEntity.fromJson(convert.jsonDecode(value.toString()));
      isLoading = false;
      if (entity.error != null) {
        ToastUtil.showError("${entity.error?.code} ${entity.error?.message}");
      } else {
        historyList.insert(
            0,
            HistoryBean(
                date: DateTime.now().millisecondsSinceEpoch,
                type: ChatType.CHAT,
                message: entity.choices!.first.message!));
        listController.animateTo(0.0,
            duration: const Duration(milliseconds: 1000), curve: Curves.ease);
        update();
      }
    }, (error) {
      // print(entity);
      if(error != null){
        ChatgptEntity entity =
        ChatgptEntity.fromJson(convert.jsonDecode(error.toString()));
        isLoading = false;
        ToastUtil.showError(entity.error?.message ?? "");
      }
    });
  }
}
