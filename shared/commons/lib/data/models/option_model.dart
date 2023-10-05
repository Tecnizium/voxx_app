import 'dart:convert';

class OptionModel {
  String? text;

  OptionModel({
    required this.text
  });

  factory OptionModel.fromJson(String source) => OptionModel.fromMap(json.decode(source));

  factory OptionModel.fromMap(Map<String, dynamic> map) {
    return OptionModel(
      text: map['text']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': text
    };
  }
}