import 'package:chatgpt_app/page/bean/history_bean.dart';
import 'package:chatgpt_app/page/chat/chat_text.dart';
import 'package:flutter/material.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/13 12:04
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ChatSendItem extends StatelessWidget {
  HistoryBean historyBean;

  ChatSendItem(this.historyBean, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      historyBean.message.role ?? "user",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 3,
                    ),
                    Text(
                      "${DateTime.fromMillisecondsSinceEpoch(historyBean.date)}",
                      style: const TextStyle(fontSize: 10),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(10),
                      //边框设置
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        //设置四周圆角 角度
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        //设置四周边框
                        border:
                            Border.all(width: 1, color: Colors.teal.shade50),
                      ),
                      child: ChatText(historyBean.message.content ?? ""),
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/images/logo_user.png",
                width: 50,
                height: 50,
              )
            ],
          ),
        ],
      ),
    );
  }
}
