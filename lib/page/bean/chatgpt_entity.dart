/// @Author: gstory
/// @CreateDate: 2023/2/13 12:12
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ChatgptEntity {
  String? id;
  String? object;
  int? created;
  String? model;
  Usage? usage;
  List<Choices>? choices;
  ChatError? error;

  ChatgptEntity(
      {this.id,
      this.object,
      this.created,
      this.model,
      this.usage,
      this.choices,
      this.error});

  ChatgptEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    created = json['created'];
    model = json['model'];
    usage = json['usage'] != null ? new Usage.fromJson(json['usage']) : null;
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(new Choices.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    data['created'] = this.created;
    data['model'] = this.model;
    if (this.usage != null) {
      data['usage'] = this.usage!.toJson();
    }
    if (this.choices != null) {
      data['choices'] = this.choices!.map((v) => v.toJson()).toList();
    }
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    return data;
  }
}

class Usage {
  int? promptTokens;
  int? completionTokens;
  int? totalTokens;

  Usage({this.promptTokens, this.completionTokens, this.totalTokens});

  Usage.fromJson(Map<String, dynamic> json) {
    promptTokens = json['prompt_tokens'];
    completionTokens = json['completion_tokens'];
    totalTokens = json['total_tokens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prompt_tokens'] = this.promptTokens;
    data['completion_tokens'] = this.completionTokens;
    data['total_tokens'] = this.totalTokens;
    return data;
  }
}

class Choices {
  Message? message;
  String? finishReason;
  int? index;

  Choices({this.message, this.finishReason, this.index});

  Choices.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
    finishReason = json['finish_reason'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    data['finish_reason'] = this.finishReason;
    data['index'] = this.index;
    return data;
  }
}

class Message {
  String? role;
  String? content;

  Message({this.role, this.content});

  Message.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    content = json['content'];
    //剔除第一个换行符
    if(content?.startsWith("\\n") ?? false){
      content?.replaceFirst("\\n", "");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['content'] = this.content;
    return data;
  }
}

class ChatError {
  String? message;
  String? type;
  Null? param;
  Null? code;

  ChatError({this.message, this.type, this.param, this.code});

  ChatError.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    type = json['type'];
    param = json['param'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['type'] = this.type;
    data['param'] = this.param;
    data['code'] = this.code;
    return data;
  }
}
