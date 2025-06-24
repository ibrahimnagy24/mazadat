import '../../../auth/login/data/entity/user_entity.dart';
import '../../../../core/shared/entity/error_entity.dart';

sealed class UserState {
  const UserState();
}

final class UserInitial extends UserState {
  const UserInitial();
}

final class UserDataLoading extends UserState {
  const UserDataLoading();
}

final class UserDataSuccess extends UserState {
  final UserEntity userEntity;
  const UserDataSuccess(this.userEntity);
}

final class UserDataError extends UserState {
  final ErrorEntity error;
  const UserDataError(this.error);
}
