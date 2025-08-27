import 'package:equatable/equatable.dart';

class HomeBundleEntity extends Equatable {
  final int id;
  final String name;
  final String price;
  final String numberOfAuctions;

  const HomeBundleEntity({
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
