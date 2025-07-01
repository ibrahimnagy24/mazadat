import 'package:equatable/equatable.dart';

class AuctionStatusesEntity extends Equatable {
  const AuctionStatusesEntity({
    required this.code,
    required this.name,
  });
  final String name,code;

  @override
  List<Object?> get props => [code, name];
}
