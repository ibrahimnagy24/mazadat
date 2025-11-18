part of 'bank_cubit.dart';

sealed class BankState {
  const BankState();
}

final class BankStart extends BankState {}

final class BankEmpty extends BankState {}

final class BankLoading extends BankState {}

final class BankDone extends BankState {
  const BankDone(this.ages);
  final List<BankEntity> ages;
}

final class BankError extends BankState {
  const BankError(this.error);
  final ErrorEntity error;
}
