import '../entities/static_page_entity.dart';

class StaticPageModel extends StaticPageEntity {
  const StaticPageModel({
    required super.id,
    required super.title,
    required super.body,
    required super.photo,
  });

  factory StaticPageModel.fromJson(Map<String, dynamic> json) =>
      StaticPageModel(
        id: json['id'],
        title: json['main_title'],
        body: json['main_value'],
        photo: json['photos'],
      );
}
