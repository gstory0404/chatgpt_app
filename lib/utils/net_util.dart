import 'dart:io';

import 'package:chatgpt_app/manager/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/13 11:34
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class NetUtils {
  static Future<void> sendMessage(
    String msg,
    Function success,
    Function fail,
  ) async {
    Dio dio = Dio();
    dio.options.headers = {
      "Authorization":
          "Bearer ${CacheManager.instance.getChatGptKey()}"
    };
    dio.options.connectTimeout = 2 * 60 * 1000; // 服务器链接超时，毫秒
    dio.options.receiveTimeout = 2 * 60 * 1000; // 响应流上前后两次接受到数据的间隔，毫秒
    dio.options.contentType = ContentType.json.toString();
    dio.options.responseType = ResponseType.json;
    dio.post("https://api.openai.com/v1/completions", data: {
      "model": "text-davinci-003",
      "prompt": msg,
      "max_tokens":2000,
      "temperature": 0.7,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0
    }).then((value) {
      success(value);
    }).catchError((e) {
      if(e.runtimeType == DioError){
        DioError dioError = e;
        fail(dioError.message);
      }else{
        fail(e);
      }
    });
  }
}
