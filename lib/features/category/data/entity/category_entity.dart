import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums/enums.dart';

class CategoryEntity extends Equatable {
  const CategoryEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.iconId,
    required this.iconUrl,
    required this.categoryType,
  });
  final int id;
  final String name;
  final String? description;
  final int? iconId;
  final String? iconUrl;
  final CategoryTypes categoryType;

  @override
  List<Object?> get props =>
      [id, name, description, iconId, iconUrl, categoryType];

  Map<String, dynamic> returnedCategoryIdMap() {
    Map<String, dynamic> map = {'id': id};
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
