import '../../../../../core/utils/utility.dart';
import '../../../../core/utils/enums/enums_converter.dart';
import '../entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.iconId,
    required super.iconUrl,
    required super.categoryType,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        iconId: checkFromMap(json['icon']) ? json['icon']['id'] : null,
        iconUrl: checkFromMap(json['icon']) ? json['icon']['path'] : null,
        categoryType: CategoryTypeConverter.stringToCategoryType(
            json['type'] ?? 'auction'),
      );
}
