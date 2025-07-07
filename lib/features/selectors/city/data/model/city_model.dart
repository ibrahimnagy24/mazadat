import '../entity/city_entity.dart';

class CityModel extends CityEntity {
  const CityModel({
    required super.id,
    required super.name,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
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
