import '../../../../core/shared/entity/error_entity.dart';
import '../../user/data/entity/user_entity.dart';


sealed class EditProfileState {
  const EditProfileState();
}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {
  const EditProfileLoading();
}

final class EditProfileSuccess extends EditProfileState {
  const EditProfileSuccess(this.userEntity);
  final UserEntity userEntity;
}

final class EditProfileError extends EditProfileState {
  const EditProfileError(this.error);
  final ErrorEntity error;
}

