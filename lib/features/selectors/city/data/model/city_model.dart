import '../../../../../core/services/pagination/pagination_service.dart';
import '../entity/city_entity.dart';

class CitiesModel {
  List<CityModel>? content;
  SearchEngine? pageable;

  CitiesModel({this.content, this.pageable});

  CitiesModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <CityModel>[];
      json['content'].forEach((v) {
        content!.add(CityModel.fromJson(v));
      });
    }
    pageable = json['pageable'] != null ? SearchEngine.fromJson(json) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    if (pageable != null) {
      data['pageable'] = pageable!.toJson();
    }
    return data;
  }
}


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
