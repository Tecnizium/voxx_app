import 'dart:convert';

import 'package:commons/data/models/option_model.dart';

class QuestionModel {
  String? id;
  String? text;
  int? type;
  List<OptionModel> options;

  QuestionModel({
    required this.id,
    required this.text,
    required this.type,
    required this.options
  });

  factory QuestionModel.fromJson(String source) => QuestionModel.fromMap(json.decode(source));

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'],
      text: map['text'],
      type: map['type'],
      options: map['options'].map<OptionModel>((option) => OptionModel.fromMap(option)).toList()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'type': type,
      'options': options.map((option) => option.toJson()).toList()
    };
  }
}