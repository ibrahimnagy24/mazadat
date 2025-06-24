import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../core/utils/enums/enums.dart';

class SaveFileParams extends Equatable {
  const SaveFileParams({
    required this.file,
    required this.fileType,
    required this.mediaType,
  });
  final File file;
  final FileTypeEnum fileType;
  final MediaType? mediaType;
  Future<Map<String, dynamic>> returnedMap() async {
    Map<String, dynamic> map = {
      'file': await getFile(),
      'type': fileType.name,
      'media_type': mediaType?.name,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  Future<MultipartFile> getFile() async {
    return await MultipartFile.fromFile(file.path);
  }

  @override
  List<Object?> get props => [file, fileType];
}
