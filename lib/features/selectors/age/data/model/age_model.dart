import '../entity/age_entity.dart';

class AgeModel extends AgeEntity {
  const AgeModel({
    required super.id,
    required super.name,
  });

  factory AgeModel.fromJson(Map<String, dynamic> json) => AgeModel(
        id: json['id'],
        name: json['name'],
      );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

}
