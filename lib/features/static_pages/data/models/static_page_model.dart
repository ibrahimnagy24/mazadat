import '../entities/static_page_entity.dart';

class StaticPageModel extends StaticPageEntity {
  const StaticPageModel({
    super.id,
    super.title,
    required super.body,
    super.photo,
    super.lastUpdateDate,
  });

  factory StaticPageModel.fromJson(Map<String, dynamic> json) =>
      StaticPageModel(
        id: json['id'],
        title: json['main_title'],
        body: json['CONTENT'],
        photo: json['photos'],
        lastUpdateDate: json['LAST_UPDATE_DATE'],
      );
}
