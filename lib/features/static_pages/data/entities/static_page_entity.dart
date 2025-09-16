import 'package:equatable/equatable.dart';

class StaticPageEntity extends Equatable {
  const StaticPageEntity({
    this.id,
    this.title,
    required this.body,
    this.photo,
    this.lastUpdateDate,
  });
  final int? id;
  final String? title;
  final String body;
  final String? photo;
  final String? lastUpdateDate;
  @override
  List<Object?> get props => [
        id,
        title,
        body,
        photo,
        lastUpdateDate,
      ];
}
