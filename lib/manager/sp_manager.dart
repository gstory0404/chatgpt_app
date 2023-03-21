import 'package:chatgpt_app/utils/language_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/global_keys.dart';

/// @Author: gstory
/// @CreateDate: 2023/3/17 12:03
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SPManager {
  factory SPManager() => _getInstance();

  static SPManager get instance => _getInstance();
  static SPManager? _instance;

  static SPManager _getInstance() {
    _instance ??= SPManager._internal();
    return _instance!;
  }

  SPManager._internal() {
    init();
  }

  SharedPreferences? _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    //sp异步的 可能会导致语言没有第一时间更新 所有初始化完成后重新更新一次
    LanguageUtil.updateLanguage();
  }

  ///保存数据
  SPManager save(String key, dynamic value) {
    print("SP save $key --> $value");
    switch (value.runtimeType) {
      case int:
        _preferences?.setInt(key, value);
        break;
      case bool:
        _preferences?.setBool(key, value);
        break;
      case double:
        _preferences?.setDouble(key, value);
        break;
      case String:
        _preferences?.setString(key, value);
        break;
      case List<String>:
        _preferences?.setStringList(key, value);
        break;
      default:
        _preferences?.setString(key, value.toString());
        break;
    }
    return this;
  }

  ///获取数据
  T get<T>(String key, dynamic defaultValue) {
    switch (T) {
      case int:
        return _preferences?.getInt(key) ?? defaultValue;
      case bool:
        return _preferences?.getBool(key) ?? defaultValue;
      case double:
        return _preferences?.getDouble(key) ?? defaultValue;
      case String:
        return _preferences?.getString(key) ?? defaultValue;
      case List<String>:
        return _preferences?.getStringList(key) ?? defaultValue;
    }
    return _preferences?.get(key) ?? defaultValue;
  }

  ///删除key
  Future<bool> remove(String key) async {
    return await _preferences?.remove(key) ?? false;
  }

  ///清空
  Future<bool> clear() async {
    return await _preferences?.clear() ?? false;
  }

  ///保存chatgpt key
  void saveChatGptKey(String? key) {
    save("chatGptKey", key);
  }

  ///获取chatgpt key
  String? getChatGptKey() {
    return get("chatGptKey", "");
  }

  ///保存语言
  void saveLanguage(String? lan) {
    save("language", lan);
  }

  ///获取语言
  String getLanguage() {
    print("获取语言 ${_preferences?.getString("language")}");
    return get("language", LanguageKey.auto);
  }
}
