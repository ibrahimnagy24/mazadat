import '../../../../../core/services/pagination/pagination_service.dart';
import '../entity/address_type_entity.dart';

class AddressTypesModel {
  List<AddressTypeModel>? content;
  SearchEngine? pageable;

  AddressTypesModel({this.content, this.pageable});

  AddressTypesModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <AddressTypeModel>[];
      json['content'].forEach((v) {
        content!.add(AddressTypeModel.fromJson(v));
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


class AddressTypeModel extends AddressTypeEntity {
  const AddressTypeModel({
    required super.id,
    required super.name,
  });

  factory AddressTypeModel.fromJson(Map<String, dynamic> json) => AddressTypeModel(
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
