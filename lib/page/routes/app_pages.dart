import 'package:chatgpt_app/page/index/index_page.dart';
import 'package:get/get.dart';

import '../index/index_ctr.dart';

/// @Author: gstory
/// @CreateDate: 2023/3/17 12:09
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class AppPages {
  static const INDEX = '/';

  static const INITIAL = INDEX;

  static final routes = [
    GetPage(
      name: INDEX,
      page: () => IndexPage(),
      binding: BindingsBuilder(() {
          Get.lazyPut(() => IndexCtr());
      }),
    ),
  ];
}