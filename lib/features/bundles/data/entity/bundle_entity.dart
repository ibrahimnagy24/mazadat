import 'package:equatable/equatable.dart';

class BundleEntity extends Equatable {
  final int id;
  final String name;
  final String openingPrice;
  final String linkedAuctionsCount;

  const BundleEntity({
    required this.id,
    required this.name,
    required this.linkedAuctionsCount,
    required this.openingPrice,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        openingPrice,
        linkedAuctionsCount,
      ];
}
