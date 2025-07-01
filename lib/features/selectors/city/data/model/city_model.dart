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
}
