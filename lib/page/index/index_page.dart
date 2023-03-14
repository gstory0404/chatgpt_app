import 'dart:io';

import 'package:chatgpt_app/manager/cache_manager.dart';
import 'package:chatgpt_app/page/chat/chat_page.dart';
import 'package:chatgpt_app/page/index/index_desktop.dart';
import 'package:chatgpt_app/page/index/index_phone.dart';
import 'package:chatgpt_app/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/14 09:11
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
    CacheManager.instance.initCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Platform.isAndroid || Platform.isIOS)
          ? const IndexPhone()
          : const IndexDesktop(),
    );
  }
}
