import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2023/3/17 12:13
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexCtr extends GetxController{
  /// 初始化控制器
  late PageController pageController;

  int chooseIndex = 0;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(
      initialPage: chooseIndex,
      keepPage: true,
    );
  }

  void changePage(int index){
    chooseIndex = index;
    pageController.jumpToPage(chooseIndex);
    update();
  }
}