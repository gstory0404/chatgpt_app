import 'package:chatgpt_app/page/bean/history_bean.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/14 11:42
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ChatUtil {
  //获取上下文
  static Future<String> getChatRelation(List<HistoryBean> list) {
    var msg = "";
    //最多关联上下文10层
    var num = 0;
    for (int i = 0;i < list.length; i++) {
      var element = list[i];
      print("${element.type} ${element.sendMsg} ${element.receiveMsg}");
      if (element.type == 1) {
        num ++;
        msg =
            "Q:${element.sendMsg}\nA:${element.receiveMsg?.choices?.first.text}\n$msg";
        if(num == 1){
          return Future(() => msg);
        }
        continue;
      }
    }
    return Future(() => msg);
  }
}
