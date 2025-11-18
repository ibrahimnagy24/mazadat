import '../../../../core/shared/entity/error_entity.dart';
import '../data/models/change_phone_number_model.dart';

sealed class ChangePhoneNumberState {
  const ChangePhoneNumberState();
}

final class ChangePhoneNumberInitial extends ChangePhoneNumberState {}

final class ChangePhoneNumberLoading extends ChangePhoneNumberState {
  const ChangePhoneNumberLoading();
}

final class ChangePHoneNumberSuccess extends ChangePhoneNumberState {
  const ChangePHoneNumberSuccess(this.data);
  final ChangePhoneNumberModel data;
}

final class ChangePhoneNumberError extends ChangePhoneNumberState {
  const ChangePhoneNumberError(this.error);
  final ErrorEntity error;
}
