import 'package:equatable/equatable.dart';

class CheckoutAddressParams extends Equatable {
  final int addressId;

  const CheckoutAddressParams({required this.addressId});

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {'id': addressId};
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [addressId];
}
