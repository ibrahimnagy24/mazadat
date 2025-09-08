import 'package:equatable/equatable.dart';

class AddressTypeEntity extends Equatable {
  const AddressTypeEntity({
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
