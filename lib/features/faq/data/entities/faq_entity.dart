import 'package:equatable/equatable.dart';

class FaqEntity extends Equatable {
  const FaqEntity({
    required this.id,
    required this.question,
    required this.answer,
  });

  final int id;
  final String question;
  final String answer;

  @override
  List<Object?> get props => [id, question, answer];
}
