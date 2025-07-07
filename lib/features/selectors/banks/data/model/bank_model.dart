import '../entity/age_entity.dart';

class BankModel extends BankEntity {
  const BankModel({
    required super.id,
    required super.name,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
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
