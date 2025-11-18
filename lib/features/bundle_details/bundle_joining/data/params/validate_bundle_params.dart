import 'package:equatable/equatable.dart';

class ValidateBundleParams extends Equatable {
  final int id;
  final List<int> avaliableAuctionsId;
  const ValidateBundleParams({
    required this.id,
    required this.avaliableAuctionsId,
  });

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'bundleId': id,
      'auctions': avaliableAuctionsId,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [id, avaliableAuctionsId];
}
