import 'package:equatable/equatable.dart';

class BankEntity extends Equatable {
  const BankEntity({
    required this.id,
    required this.name,
  });
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
