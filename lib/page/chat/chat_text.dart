import 'package:flutter/material.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/13 16:53
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ChatText extends StatelessWidget {
  String text;

  ChatText(this.text,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: text, // default text style
        children: <TextSpan>[],
      ),
    );
  }
}
