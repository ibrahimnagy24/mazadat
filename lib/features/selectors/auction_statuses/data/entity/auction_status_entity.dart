import 'package:equatable/equatable.dart';

class AuctionStatusEntity extends Equatable {
  const AuctionStatusEntity({
    required this.value,
    required this.label,
  });
  final String label,value;

  @override
  List<Object?> get props => [value, label];
}
