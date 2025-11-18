import 'package:equatable/equatable.dart';

class AgeEntity extends Equatable {
  const AgeEntity({
    required this.id,
    required this.name,
  });
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
