import '../../../../core/shared/entity/error_entity.dart';

sealed class DeleteAddressState {
  const DeleteAddressState();
}

final class DeleteAddressInitial extends DeleteAddressState {}

final class DeleteAddressLoading extends DeleteAddressState {
  const DeleteAddressLoading();
}

final class DeleteAddressSuccess extends DeleteAddressState {
  const DeleteAddressSuccess();
}

final class DeleteAddressError extends DeleteAddressState {
  const DeleteAddressError(this.error);
  final ErrorEntity error;
}

