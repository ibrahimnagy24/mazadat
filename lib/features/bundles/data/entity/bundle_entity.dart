import 'package:equatable/equatable.dart';

class BundleEntity extends Equatable {
  final int id;
  final String name;
  final String price;
  final String numberOfAuctions;

  const BundleEntity({
    required this.id,
    required this.name,
    required this.numberOfAuctions,
    required this.price,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        numberOfAuctions,
      ];
}
