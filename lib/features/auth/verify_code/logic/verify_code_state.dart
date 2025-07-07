import '../../../../core/shared/entity/error_entity.dart';
import '../../../user/data/entity/user_entity.dart';
import '../data/models/send_code_model.dart';

sealed class VerifyCodeState {
  const VerifyCodeState();
}

final class VerifyCodeInitial extends VerifyCodeState {}

final class VerifyCodeLoading extends VerifyCodeState {
  const VerifyCodeLoading();
}

final class VerifyCodeSuccess extends VerifyCodeState {
  const VerifyCodeSuccess(this.data);
  final UserEntity data;
}

final class VerifyCodeError extends VerifyCodeState {
  const VerifyCodeError(this.error);
  final ErrorEntity error;
}

final class ResendVerifyCodeLoading extends VerifyCodeState {
  const ResendVerifyCodeLoading();
}

final class ResendVerifyCodeSucess extends VerifyCodeState {
  const ResendVerifyCodeSucess(this.data);
  final SendCodeModel data;
}

final class ResendVerifyCodeError extends VerifyCodeState {
  const ResendVerifyCodeError(this.error);
  final ErrorEntity error;
}

final class TimerChanged extends VerifyCodeState {}
