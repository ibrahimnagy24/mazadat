import '../../../../../core/services/pagination/pagination_service.dart';
import '../entity/region_entity.dart';

class RegionsModel {
  List<RegionModel>? content;
  SearchEngine? pageable;

  RegionsModel({this.content, this.pageable});

  RegionsModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <RegionModel>[];
      json['content'].forEach((v) {
        content!.add(RegionModel.fromJson(v));
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

class RegionModel extends RegionEntity {
  const RegionModel({
    required super.id,
    required super.name,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
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
