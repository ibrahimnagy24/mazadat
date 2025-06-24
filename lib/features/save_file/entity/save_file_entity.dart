import 'package:equatable/equatable.dart';

class SaveFileEntity extends Equatable {
  const SaveFileEntity({
    required this.message,
    required this.fileId,
    required this.path,
  });
  final String? message;
  final int fileId;
  final String path;

  @override
  List<Object?> get props => [message, fileId, path];
}
