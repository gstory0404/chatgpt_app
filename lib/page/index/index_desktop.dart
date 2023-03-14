import 'package:chatgpt_app/page/chat/chat_page.dart';
import 'package:chatgpt_app/page/setting/setting_page.dart';
import 'package:flutter/material.dart';

import '../image/image_page.dart';

/// @Author: gstory
/// @CreateDate: 2023/3/14 11:36
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexDesktop extends StatefulWidget {
  const IndexDesktop({Key? key}) : super(key: key);

  @override
  State<IndexDesktop> createState() => _IndexDesktopState();
}

class _IndexDesktopState extends State<IndexDesktop> with AutomaticKeepAliveClientMixin {
  /// 初始化控制器
  late PageController pageController;
  int _chooseIndex = 0;

  @override
  bool get wantKeepAlive => true;

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
          destinations: const [
            NavigationRailDestination(
                icon: Icon(Icons.message_outlined), label: Text("聊天")),
            NavigationRailDestination(
                icon: Icon(Icons.image), label: Text("图片")),
            NavigationRailDestination(
                icon: Icon(Icons.settings), label: Text("设置")),
          ],
          selectedIndex: _chooseIndex,
          onDestinationSelected: (index) {
            pageController.jumpToPage(index);
            setState(() {
              _chooseIndex = index;
            });
          },
        ),
        Expanded(
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            itemBuilder: (BuildContext context, int index) {
              switch (index) {
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
      ],
    );
  }
}
