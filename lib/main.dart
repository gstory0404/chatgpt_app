import 'dart:io';

import 'package:chatgpt_app/lang/translation_service.dart';
import 'package:chatgpt_app/page/index/index_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'manager/sp_manager.dart';
import 'page/routes/app_pages.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initWindow();
  SPManager.instance.init();
  runApp(const MyApp());
}

void initWindow() async {
  if (Platform.isFuchsia ||
      Platform.isLinux ||
      Platform.isMacOS ||
      Platform.isWindows) {
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      // 隐藏窗口标题栏
      await windowManager.setTitleBarStyle(TitleBarStyle.normal);
      await windowManager.setSize(const Size(800, 880));
      // await windowManager.setMaximumSize(const Size(1000, 1000));
      await windowManager.setMinimumSize(const Size(540, 880));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setSkipTaskbar(false);
    });
  } else if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.tealAccent,
      ),
      //语言
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      debugShowCheckedModeBanner:false,
      //路由
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
