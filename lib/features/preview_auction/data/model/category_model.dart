// Removed preview_auction specific imports - using basic types instead

class CategoryModel {
  final int id;
  final String name;
  final String description;
  final String iconUrl;
  final String categoryType;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.categoryType,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        // ignore: prefer_if_null_operators
        iconUrl: json['icon'] != null ? json['icon'] : '',
        categoryType: json['categoryType']?.toString() ?? 'general',
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['iconUrl'] = iconUrl;
    data['categoryType'] = categoryType;
    return data;
  }
}
