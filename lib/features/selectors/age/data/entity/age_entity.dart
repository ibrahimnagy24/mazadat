import 'package:equatable/equatable.dart';

class AgeEntity extends Equatable {
  const AgeEntity({
    required this.id,
    required this.name,
    required this.description,
  });
  final int id;
  final String name;
  final String? description;

  @override
  List<Object?> get props => [id, name, description];
}
