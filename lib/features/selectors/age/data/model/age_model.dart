import '../entity/age_entity.dart';

class AgeModel extends AgeEntity {
  const AgeModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory AgeModel.fromJson(Map<String, dynamic> json) => AgeModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
      );
}
