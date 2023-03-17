import 'package:chatgpt_app/page/chat/chat_page.dart';
import 'package:chatgpt_app/page/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../lang/strings.dart';
import '../image/image_page.dart';
import 'index_ctr.dart';

/// @Author: gstory
/// @CreateDate: 2023/3/14 11:36
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<IndexCtr>(
        builder: (controller) {
          return Row(
            children: [
              NavigationRail(
                minWidth: 70,
                extended: false,
                trailing: Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ),
                labelType: NavigationRailLabelType.all,
                destinations: [
                  NavigationRailDestination(
                      icon: const Icon(Icons.message_outlined), label: Text(Strings.chat.tr)),
                  NavigationRailDestination(
                      icon: const Icon(Icons.image), label: Text(Strings.image.tr)),
                  NavigationRailDestination(
                      icon: const Icon(Icons.settings), label: Text(Strings.setting.tr)),
                ],
                selectedIndex: controller.chooseIndex,
                onDestinationSelected: controller.changePage,
              ),
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
            ],
          );
        },
      ),
    );
  }
}
