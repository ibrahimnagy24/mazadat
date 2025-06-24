import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  const CategoryEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.iconId,
    required this.iconUrl,
  });
  final int id;
  final String name;
  final String? description;
  final int? iconId;
  final String? iconUrl;

  @override
  List<Object?> get props => [id, name, description, iconId, iconUrl];
}
