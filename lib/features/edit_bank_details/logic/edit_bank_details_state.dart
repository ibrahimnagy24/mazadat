import '../../../../core/shared/entity/error_entity.dart';
import '../../user/data/entity/user_entity.dart';


sealed class EditBankDetailsState {
  const EditBankDetailsState();
}

final class EditBankDetailsInitial extends EditBankDetailsState {}

final class EditBankDetailsLoading extends EditBankDetailsState {
  const EditBankDetailsLoading();
}

final class EditBankDetailsSuccess extends EditBankDetailsState {
  const EditBankDetailsSuccess(this.userEntity);
  final UserEntity userEntity;
}

final class EditBankDetailsError extends EditBankDetailsState {
  const EditBankDetailsError(this.error);
  final ErrorEntity error;
}

