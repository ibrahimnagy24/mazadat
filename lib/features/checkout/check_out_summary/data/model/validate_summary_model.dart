import '../entity/validate_summary_entity.dart';

class ValidateSummaryModel extends ValidateSummaryEntity {
  const ValidateSummaryModel({required super.message});

  factory ValidateSummaryModel.fromJson(Map<String, dynamic> json) =>
      ValidateSummaryModel(message: json['MESSAGE']);
}
