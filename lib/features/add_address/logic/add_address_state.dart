import '../../../../core/shared/entity/error_entity.dart';

sealed class AddAddressState {
  const AddAddressState();
}

final class AddAddressInitial extends AddAddressState {}

final class AddAddressLoading extends AddAddressState {
  const AddAddressLoading();
}

final class AddAddressSuccess extends AddAddressState {
  const AddAddressSuccess();
}

final class AddAddressError extends AddAddressState {
  const AddAddressError(this.error);
  final ErrorEntity error;
}

