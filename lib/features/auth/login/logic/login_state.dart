import '../../../../core/shared/entity/error_entity.dart';
import '../../../user/data/entity/user_entity.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginSuccess extends LoginState {
  const LoginSuccess(this.loginEntity);
  final UserEntity loginEntity;
}

final class LoginError extends LoginState {
  const LoginError(this.error);
  final ErrorEntity error;
}

final class RememberMeStates extends LoginState {}
