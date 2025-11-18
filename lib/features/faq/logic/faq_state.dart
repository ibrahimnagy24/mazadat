import '../../../core/shared/entity/error_entity.dart';
import '../data/entities/faq_entity.dart';

sealed class FaqState {
  const FaqState();
}

final class FaqInitial extends FaqState {}

final class FaqLoading extends FaqState {}

final class FaqSuccess extends FaqState {
  const FaqSuccess(this.faqs);
  final List<FaqEntity> faqs;
}

final class FaqError extends FaqState {
  const FaqError(this.error);
  final ErrorEntity error;
}

final class FaqEmpty extends FaqState {}
