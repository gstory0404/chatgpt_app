import 'dart:ui';

import 'package:chatgpt_app/config/global_keys.dart';
import 'package:chatgpt_app/manager/sp_manager.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2023/3/17 12:02
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述
///

class LanguageUtil{

  //获取当前语言
  static String getLanguage(){
    var language = SPManager().getLanguage();
    return language;
  }

  //设置语言
  static void setLanguage(String lan){
    SPManager().saveLanguage(lan);
    var locale = getLanguageLocale(lan);
    Get.updateLocale(locale);
  }

  //获取Locale
  static Locale getLanguageLocale(String lan){
    switch(lan){
      case LanguageKey.en:
        return const Locale('en', 'US');
      case LanguageKey.zh:
        return const Locale('zh', 'CN');
    }
    return Get.deviceLocale ?? const Locale('zh', 'CN');
  }
}