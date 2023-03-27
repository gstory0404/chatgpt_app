import 'dart:convert';
import 'dart:io';

import 'package:chatgpt_app/page/bean/chatgpt_entity.dart';
import 'package:dio/dio.dart';

import '../manager/sp_manager.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/13 11:34
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class NetUtils {
  static Future<void> sendMessage(
    List<Message> messages,
    Function success,
    Function fail,
  ) async {
    Dio dio = Dio();
    dio.options.headers = {
      "Authorization": "Bearer ${SPManager.instance.getChatGptKey()}",
      "content-type": " application/json"
    };
    dio.options.connectTimeout = const Duration(minutes: 1); // 服务器链接超时，1分钟
    dio.options.receiveTimeout = const Duration(minutes: 1); // 响应流上前后两次接受到数据的间隔，1分钟
    dio.options.contentType = ContentType.json.toString();
    dio.options.responseType = ResponseType.json;
    // print("send===> ${json.encode(messages)}");
    dio.post("https://api.openai.com/v1/chat/completions", data: {
      "model": "gpt-3.5-turbo",
      "messages": messages,
      "max_tokens": SPManager.instance.getChatMaxToken(),
      "temperature": 0.4,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0
    }).then((value) {
      success(value);
    }).catchError((e) {
      if (e is DioError) {
        DioError dioError = e;
        fail(dioError.response);
        print("请求异常 ${dioError.response}");
      } else {
        fail(e);
      }
    });
  }
}
