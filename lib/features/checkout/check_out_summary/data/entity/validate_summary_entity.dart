import 'package:equatable/equatable.dart';

class ValidateSummaryEntity extends Equatable {
  final String message;

  const ValidateSummaryEntity({required this.message});

  @override
  List<Object?> get props => [message];
}
