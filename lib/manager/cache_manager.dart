import 'package:shared_preferences/shared_preferences.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/14 16:45
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class CacheManager {
  factory CacheManager() => _getInstance();
  static CacheManager get instance => _getInstance();
  static CacheManager? _instance;
  static CacheManager _getInstance() {
    _instance ??= CacheManager._internal();
    return _instance!;
  }

  CacheManager._internal() {

  }

  String? _chatGptKey = "";

  Future<void> initCache() async {
    final prefs = await SharedPreferences.getInstance();
    _chatGptKey = prefs.getString('chatGptKey');
  }

  String? getChatGptKey(){
    return _chatGptKey;
  }

  void saveChatGptKey(String key) async {
    _chatGptKey = key;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('chatGptKey', key);
  }
}