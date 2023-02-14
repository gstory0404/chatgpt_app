import 'package:flutter/material.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/14 09:26
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 200,
      child: Column(
        children: [
          _item("chargpt key", (value) {
            print("===>$value");
          })
        ],
      ),
    );
  }

  _item(String title, ValueChanged<String>? changed) {
    return Container(
      child: Row(
        children: [
          Text(title, style: TextStyle(fontSize: 16),),
          TextField(
            onChanged: changed,
          )
        ],
      ),
    );
  }
}
