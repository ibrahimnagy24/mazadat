import 'package:equatable/equatable.dart';

class ValidateSummaryParams extends Equatable {
  final int auctionId;

  const ValidateSummaryParams({required this.auctionId});

  @override
  List<Object?> get props => [auctionId];

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {'auctionId': auctionId};
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
