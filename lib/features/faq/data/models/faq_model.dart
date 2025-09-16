import '../entities/faq_entity.dart';

class FaqModel extends FaqEntity {
  const FaqModel({
    required super.id,
    required super.question,
    required super.answer,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        id: json['id'],
        question: json['question'],
        answer: json['answer'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }
}
