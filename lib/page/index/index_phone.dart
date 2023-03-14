import 'package:flutter/material.dart';

import '../chat/chat_page.dart';
import '../image/image_page.dart';
import '../setting/setting_page.dart';

/// @Author: gstory
/// @CreateDate: 2023/3/14 11:57
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexPhone extends StatefulWidget {
  const IndexPhone({Key? key}) : super(key: key);

  @override
  State<IndexPhone> createState() => _IndexPhoneState();
}

class _IndexPhoneState extends State<IndexPhone> {
  int choose = 0;

  /// 初始化控制器
  late PageController pageController;

  int _chooseIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: _chooseIndex,
      keepPage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              itemBuilder: (BuildContext context, int index) {
                switch (choose) {
                  //聊天
                  case 0:
                    return const ChatPage();
                  //图片
                  case 1:
                    return const ImagePage();
                  //设置
                  case 2:
                    return const SettingPage();
                }
              },
            ),
          ),
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.message_outlined), label: "聊天"),
              BottomNavigationBarItem(icon: Icon(Icons.image), label: "图片"),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "设置"),
            ],
            currentIndex: _chooseIndex,
            onTap: (index) {
              pageController.jumpToPage(index);
              setState(() {
                _chooseIndex = index;
              });
            },
          )
        ],
      ),
    );
  }
}
