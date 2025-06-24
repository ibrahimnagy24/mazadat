import 'package:equatable/equatable.dart';

class StaticPageEntity extends Equatable {
  const StaticPageEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.photo,
  });
  final int id;
  final String title;
  final String body;
  final String? photo;
  @override
  List<Object?> get props => [
        id,
        title,
        body,
        photo,
      ];
}
