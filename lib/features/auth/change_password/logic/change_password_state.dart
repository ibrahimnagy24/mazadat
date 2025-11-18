import '../../../../core/shared/entity/error_entity.dart';
import '../data/models/change_password_model.dart';

sealed class ChangePasswordState {
  const ChangePasswordState();
}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ResetPasswordLoading extends ChangePasswordState {
  const ResetPasswordLoading();
}

final class ChangePasswordSuccess extends ChangePasswordState {
  const ChangePasswordSuccess(this.data);
  final ChangePasswordModel data;
}

final class ChangePasswordError extends ChangePasswordState {
  const ChangePasswordError(this.error);
  final ErrorEntity error;
}
