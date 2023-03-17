import 'dart:ui';

import 'package:chatgpt_app/lang/zh_CN.dart';
import 'package:chatgpt_app/utils/language_util.dart';
import 'package:get/get.dart';

import 'en_US.dart';

/// @Author: gstory
/// @CreateDate: 2023/3/17 11:58
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class TranslationService extends Translations {

  static Locale? get locale => LanguageUtil.getLanguageLocale(LanguageUtil.getLanguage());

  static const fallbackLocale = Locale('zh', 'CN');

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en_US,
    'zh_CN': zh_CN,
  };
}
