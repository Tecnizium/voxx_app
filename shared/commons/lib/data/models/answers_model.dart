import 'dart:convert';

class AnswersModel {
  String? pollId;
  List<OptionSelectedModel>? answers;

  AnswersModel({
    required this.pollId,
    required this.answers,
  });

  factory AnswersModel.fromJson(String source) => AnswersModel.fromMap(json.decode(source));

  factory AnswersModel.fromMap(Map<String, dynamic> map) {
    return AnswersModel(
      pollId: map['pollId'],
      answers: List<OptionSelectedModel>.from(map['answers']?.map((x) => OptionSelectedModel.fromMap(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pollId': pollId,
      'answers': answers?.map((x) => x.toJson()).toList(),
    };
  }
}

class OptionSelectedModel {
  String? questionId;
  String? value;

  OptionSelectedModel({
    required this.questionId,
    required this.value,
  });

  factory OptionSelectedModel.fromJson(String source) => OptionSelectedModel.fromMap(json.decode(source));

  factory OptionSelectedModel.fromMap(Map<String, dynamic> map) {
    return OptionSelectedModel(
      questionId: map['questionId'],
      value: map['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'value': value,
    };
  }
}