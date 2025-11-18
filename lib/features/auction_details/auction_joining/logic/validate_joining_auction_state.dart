import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/shared/models/auction_policy_model.dart';

sealed class ValidateJoiningAuctionState {
  const ValidateJoiningAuctionState();
}

class ValidateJoiningAuctionInitial extends ValidateJoiningAuctionState {}

class ValidateJoiningAuctionLoading extends ValidateJoiningAuctionState {}

class ValidateJoiningAuctionSuccess extends ValidateJoiningAuctionState {
  final AuctionPolicyModel data;
  const ValidateJoiningAuctionSuccess({required this.data});
}

class ValidateJoiningAuctionError extends ValidateJoiningAuctionState {
  final ErrorEntity error;
  const ValidateJoiningAuctionError(this.error);
}
