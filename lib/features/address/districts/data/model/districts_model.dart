import '../../../../../core/services/pagination/pagination_service.dart';
import '../entity/district_entity.dart';

class DistrictsModel {
  List<DistrictModel>? content;
  SearchEngine? pageable;

  DistrictsModel({this.content, this.pageable});

  DistrictsModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <DistrictModel>[];
      json['content'].forEach((v) {
        content!.add(DistrictModel.fromJson(v));
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

class DistrictModel extends DistrictEntity {
  const DistrictModel({
    required super.id,
    required super.name,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
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
