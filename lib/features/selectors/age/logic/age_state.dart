part of 'age_cubit.dart';

sealed class AgeState {
  const AgeState();
}

final class AgeStart extends AgeState {}

final class AgeEmpty extends AgeState {}

final class AgeLoading extends AgeState {}

final class AgeDone extends AgeState {
  const AgeDone(this.ages);
  final List<AgeEntity> ages;
}

final class AgeError extends AgeState {
  const AgeError(this.error);
  final ErrorEntity error;
}
