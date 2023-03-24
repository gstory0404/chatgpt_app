import 'package:chatgpt_app/page/bean/chatgpt_entity.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/13 14:36
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述
///

class ChatType{
  static String CHAT = "chat";
  static String IMAGE = "image";
}

class HistoryBean{
  int date;
  //chat聊天 image图片
  String type;
  Message message;

  HistoryBean({required this.date,required this.type,required this.message});
}