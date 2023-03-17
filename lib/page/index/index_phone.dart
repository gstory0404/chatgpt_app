import 'package:chatgpt_app/page/index/index_ctr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../lang/strings.dart';
import '../chat/chat_page.dart';
import '../image/image_page.dart';
import '../setting/setting_page.dart';

/// @Author: gstory
/// @CreateDate: 2023/3/14 11:57
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexPhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<IndexCtr>(
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  itemBuilder: (BuildContext context, int index) {
                    switch (index) {
                      //聊天
                      case 0:
                        return ChatPage();
                      //图片
                      case 1:
                        return ImagePage();
                      //设置
                      case 2:
                        return SettingPage();
                    }
                  },
                ),
              ),
              BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.message_outlined),
                      label: Strings.chat.tr),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.image), label: Strings.image.tr),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.settings),
                      label: Strings.setting.tr),
                ],
                currentIndex: controller.chooseIndex,
                onTap: controller.changePage,
              )
            ],
          );
        },
      ),
    );
  }
}
