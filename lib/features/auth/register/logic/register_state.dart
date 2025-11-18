import '../../../../core/shared/entity/error_entity.dart';
import '../data/model/register_model.dart';

sealed class RegisterState {
  const RegisterState();
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

final class RegisterSucess extends RegisterState {
  const RegisterSucess(this.registerEntity);
  final RegisterModel registerEntity;
}

final class RegisterError extends RegisterState {
  const RegisterError(this.error);
  final ErrorEntity error;
}

final class AgreePolicyAndConditionsState extends RegisterState {}

final class RegisterStepChanged extends RegisterState {
  RegisterStepChanged(this.step);
  final int step;
}

final class RebuildInputs extends RegisterState {}
