import '../../../../core/shared/entity/error_entity.dart';
import '../../../address/addresses/data/model/addresses_model.dart';
import '../data/model/checkout_model.dart';

sealed class CheckoutAddressState {
  const CheckoutAddressState();
}

final class CheckoutAddressInitial extends CheckoutAddressState {
  const CheckoutAddressInitial();
}

final class CheckoutAddressLoading extends CheckoutAddressState {
  const CheckoutAddressLoading();
}

final class CheckoutAddressLoaded extends CheckoutAddressState {
  final List<AddressModel> addresses;

  const CheckoutAddressLoaded({
    required this.addresses,
  });
}

final class CheckoutAddressSelected extends CheckoutAddressState {
  final List<AddressModel> addresses;
  final AddressModel selectedAddress;

  const CheckoutAddressSelected({
    required this.addresses,
    required this.selectedAddress,
  });
}

final class CheckoutAddressEmpty extends CheckoutAddressState {
  const CheckoutAddressEmpty();
}

final class CheckoutAddressError extends CheckoutAddressState {
  final ErrorEntity error;
  const CheckoutAddressError(this.error);
}

final class SetDefaultAddressLoading extends CheckoutAddressState {
  SetDefaultAddressLoading();
}

final class SetDefaultAddressSuccess extends CheckoutAddressState {
  final CheckoutModel checkoutModel;
  const SetDefaultAddressSuccess(this.checkoutModel);
}

final class SetDefaultAddressError extends CheckoutAddressState {
  final ErrorEntity error;
  const SetDefaultAddressError(this.error);
}
