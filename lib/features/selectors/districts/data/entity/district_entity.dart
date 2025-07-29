import 'package:equatable/equatable.dart';

class DistrictEntity extends Equatable {
  const DistrictEntity({
    required this.id,
    required this.name,
  });
  final int id;
  final String name;

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
