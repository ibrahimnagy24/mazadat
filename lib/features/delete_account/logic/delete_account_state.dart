import '../../../../core/shared/entity/error_entity.dart';

sealed class DeleteAccountState {
  const DeleteAccountState();
}

final class DeleteAccountInitial extends DeleteAccountState {}

final class DeleteAccountLoading extends DeleteAccountState {
  const DeleteAccountLoading();
}

final class DeleteAccountSuccess extends DeleteAccountState {
  const DeleteAccountSuccess();
}

final class DeleteAccountError extends DeleteAccountState {
  const DeleteAccountError(this.error);
  final ErrorEntity error;
}

