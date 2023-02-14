/// @Author: gstory
/// @CreateDate: 2023/2/13 12:12
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ChatgptEntity {
  String? id;
  String? object;
  int? created;
  String? model;
  List<Choices>? choices;
  Usage? usage;
  Error? error;

  ChatgptEntity(
      {this.id,
      this.object,
      this.created,
      this.model,
      this.choices,
      this.usage,
      this.error});

  ChatgptEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    created = json['created'];
    model = json['model'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(Choices.fromJson(v));
      });
    }
    usage = json['usage'] != null ? Usage.fromJson(json['usage']) : null;
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['object'] = object;
    data['created'] = created;
    data['model'] = model;
    if (choices != null) {
      data['choices'] = choices!.map((v) => v.toJson()).toList();
    }
    if (usage != null) {
      data['usage'] = usage!.toJson();
    }
    return data;
  }
}

class Choices {
  String? text;
  int? index;
  String? logprobs;
  String? finishReason;

  Choices({this.text, this.index, this.logprobs, this.finishReason});

  Choices.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    while(text?.startsWith("\n") ?? false){
      text = text?.replaceFirst("\n", "");
    }
    index = json['index'];
    logprobs = json['logprobs'];
    finishReason = json['finish_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['index'] = index;
    data['logprobs'] = logprobs;
    data['finish_reason'] = finishReason;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prompt_tokens'] = promptTokens;
    data['completion_tokens'] = completionTokens;
    data['total_tokens'] = totalTokens;
    return data;
  }
}

class Error {
  String? message;
  String? type;
  Null? param;
  String? code;

  Error({this.message, this.type, this.param, this.code});

  Error.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    type = json['type'];
    param = json['param'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['type'] = type;
    data['param'] = param;
    data['code'] = code;
    return data;
  }
}
