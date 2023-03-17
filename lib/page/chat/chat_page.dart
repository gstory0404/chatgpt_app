import 'dart:io';

import 'package:chatgpt_app/lang/strings.dart';
import 'package:chatgpt_app/page/bean/history_bean.dart';
import 'package:chatgpt_app/page/chat/chat_ctr.dart';
import 'package:chatgpt_app/page/chat/chat_receive_item.dart';
import 'package:chatgpt_app/page/chat/chat_send_item.dart';
import 'package:chatgpt_app/utils/net_util.dart';
import 'package:chatgpt_app/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bean/chatgpt_entity.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/13 10:46
/// @Email gstory0404@gmail.com
/// @Description: 聊天界面

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (Platform.isAndroid || Platform.isIOS)
          ? AppBar(
              title: Text(Strings.chat.tr),
              centerTitle: true,
            )
          : null,
      body: GetBuilder<ChatCtr>(
          init: Get.put(ChatCtr()),
          builder: (controller) {
            return Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: controller.historyList.length,
                        reverse: true,
                        controller: controller.listController,
                        itemBuilder: (BuildContext context, int index) {
                          if (controller.historyList[index].message.role ==
                              "user") {
                            return ChatSendItem(controller.historyList[index]);
                          } else if (controller
                                  .historyList[index].message.role ==
                              "assistant") {
                            return ChatReceiveItem(
                                controller.historyList[index]);
                          } else if (controller
                                  .historyList[index].message.role ==
                              "system") {
                            return ChatReceiveItem(
                                controller.historyList[index]);
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.black12,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            child: TextField(
                              maxLines: 5,
                              minLines: 1,
                              controller: controller.inputController,
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
                          onPressed: controller.sendMsg,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal.shade50,
                            elevation: 1,
                            minimumSize: const Size(0, 40),
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            side: BorderSide(
                                color: Colors.teal.shade50, width: 1),
                          ),
                          child: Text(
                            Strings.send.tr,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
