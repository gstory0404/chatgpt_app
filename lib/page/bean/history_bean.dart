import 'package:chatgpt_app/page/bean/chatgpt_entity.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/13 14:36
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class HistoryBean{
  //0发送 1接收
  int type;
  //chatgpt回复
  ChatgptEntity? receiveMsg;
  //发送信息
  String? sendMsg;
  //api请求数据
  String? prompt = "";

  HistoryBean(this.type,{this.sendMsg,this.receiveMsg,this.prompt});
}