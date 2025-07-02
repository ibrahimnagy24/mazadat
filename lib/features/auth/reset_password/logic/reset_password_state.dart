import '../../../../core/shared/entity/error_entity.dart';
import '../data/models/reset_password_model.dart';

sealed class ResetPasswordState {
  const ResetPasswordState();
}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordLoading extends ResetPasswordState {
  const ResetPasswordLoading();
}

final class ResetPasswordSuccess extends ResetPasswordState {
  const ResetPasswordSuccess(this.data);
  final ResetPasswordModel data;
}

final class ResetPasswordError extends ResetPasswordState {
  const ResetPasswordError(this.error);
  final ErrorEntity error;
}
