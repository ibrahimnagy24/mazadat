import '../../../../core/shared/entity/error_entity.dart';
import '../data/models/forget_password_model.dart';

sealed class ForgetPasswordState {
  const ForgetPasswordState();
}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {
  const ForgetPasswordLoading();
}

final class ForgetPasswordSuccess extends ForgetPasswordState {
  const ForgetPasswordSuccess(this.data);
  final ForgetPasswordModel data;
}

final class ForgetPasswordError extends ForgetPasswordState {
  const ForgetPasswordError(this.error);
  final ErrorEntity error;
}
