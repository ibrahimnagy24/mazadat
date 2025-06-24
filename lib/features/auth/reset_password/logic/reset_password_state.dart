import '../../../../core/shared/entity/error_entity.dart';
import '../data/models/reset_password_model.dart';

sealed class ResetPasswordState {
  const ResetPasswordState();
}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordLoading extends ResetPasswordState {
  const ResetPasswordLoading();
}

final class ResetPasswordSucess extends ResetPasswordState {
  const ResetPasswordSucess(this.data);
  final ResetPasswordModel data;
}

final class ResetPasswordError extends ResetPasswordState {
  const ResetPasswordError(this.error);
  final ErrorEntity error;
}
