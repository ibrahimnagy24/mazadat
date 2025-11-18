import '../../../../../core/utils/utility.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/enums/enums_converter.dart';
import '../entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.iconUrl,
    required super.categoryType,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        iconUrl: checkFromMap(json['icon']) ? json['icon']['path'] : null,
        categoryType: CategoryTypeConverter.stringToCategoryType(
            json['type'] ?? 'auction'),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['icon'] = iconUrl;
    data['type'] = CategoryTypes.auction.name;
    return data;
  }
}
