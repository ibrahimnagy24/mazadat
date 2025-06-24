import '../../../../core/shared/entity/error_entity.dart';
import '../data/model/visitor_model.dart';

sealed class VisitorState {
  const VisitorState();
}

final class VisitorInitial extends VisitorState {
  const VisitorInitial();
}

final class VisitorLoginLoading extends VisitorState {
  const VisitorLoginLoading();
}

final class VisitorLoginSuccess extends VisitorState {
  final VisitorModel visitor;
  const VisitorLoginSuccess(this.visitor);
}

final class VisitorLoginError extends VisitorState {
  final ErrorEntity error;
  const VisitorLoginError(this.error);
}
