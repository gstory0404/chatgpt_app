import 'package:chatgpt_app/page/bean/history_bean.dart';
import 'package:chatgpt_app/page/chat/chat_text.dart';
import 'package:flutter/material.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/13 15:41
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ChatReceiveItem extends StatefulWidget {
  HistoryBean historyBean;

  ChatReceiveItem(this.historyBean, {Key? key}) : super(key: key);

  @override
  State<ChatReceiveItem> createState() => _ChatReceiveItemState();
}

class _ChatReceiveItemState extends State<ChatReceiveItem>
    with SingleTickerProviderStateMixin {
  /// 持续时间为10秒的动画控制器
  late final AnimationController _controller;

  late final Animation<String> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
          milliseconds: widget.historyBean.message.content!.length * 10),
    )..forward();
    _animation = TextTween(end: widget.historyBean.message.content ?? "")
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.historyBean.message.toJson());
    return Container(
      alignment: AlignmentDirectional.centerStart,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                widget.historyBean.message.role == "system" ? "assets/images/logo_system.png" : "assets/images/logo_chatgpt.png",
                width: 50,
                height: 50,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.historyBean.message.role ?? "assistant",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 3,
                    ),
                    Text(
                      "${DateTime.fromMillisecondsSinceEpoch(widget.historyBean.date)}",
                      style: const TextStyle(fontSize: 10),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(10),
                      //边框设置
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        //设置四周圆角 角度
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        //设置四周边框
                        border:
                            Border.all(width: 1, color: Colors.amber.shade50),
                      ),
                      child: widget.historyBean.date >
                              DateTime.now().millisecondsSinceEpoch - 500
                          ? _animationText()
                          : ChatText(widget.historyBean.message.content ?? ""),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _animationText() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ChatText(
          _animation.value,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class TextTween extends Tween<String> {
  TextTween({String end = ''}) : super(begin: '', end: end);

  @override
  String lerp(double t) {
    var cutoff = (end!.length * t).round();
    return end!.substring(0, cutoff);
  }
}
