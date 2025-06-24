import '../entity/save_file_entity.dart';

class SaveFileModel extends SaveFileEntity {
  const SaveFileModel({
    required super.message,
    required super.fileId,
    required super.path,
  });

  factory SaveFileModel.fromJson(Map<String, dynamic> json,
          {String? message}) =>
      SaveFileModel(
        message: message,
        fileId: json['id'],
        path: json['url'],
      );
}
