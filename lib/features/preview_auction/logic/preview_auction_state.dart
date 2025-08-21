import '../data/model/auction_details_model.dart';
import '../data/model/auction_pusher_model.dart';

sealed class PreviewAuctionState {
  const PreviewAuctionState();
}

final class PreviewAuctionInitial extends PreviewAuctionState {}

final class PreviewAuctionLoading extends PreviewAuctionState {}

final class PreviewAuctionDetailsSuccess extends PreviewAuctionState {
  final AuctionDetailsModel auctionDetails;
  
  const PreviewAuctionDetailsSuccess(this.auctionDetails);
}

final class PreviewAuctionJoinSuccess extends PreviewAuctionState {
  final String message;
  
  const PreviewAuctionJoinSuccess(this.message);
}

final class PreviewAuctionBidSuccess extends PreviewAuctionState {
  final String message;
  final double newBidAmount;
  
  const PreviewAuctionBidSuccess(this.message, this.newBidAmount);
}

final class PreviewAuctionError extends PreviewAuctionState {
  final String message;
  
  const PreviewAuctionError(this.message);
}

// Real-time bidding updates from Pusher
final class PreviewAuctionBidUpdate extends PreviewAuctionState {
  final AuctionPusherModel bidData;
  
  const PreviewAuctionBidUpdate(this.bidData);
}

// Validation states
final class PreviewAuctionValidationLoading extends PreviewAuctionState {}

final class PreviewAuctionValidationSuccess extends PreviewAuctionState {
  final dynamic validationData;
  
  const PreviewAuctionValidationSuccess(this.validationData);
}

final class PreviewAuctionValidationError extends PreviewAuctionState {
  final String message;
  
  const PreviewAuctionValidationError(this.message);
}

// Joining states
final class PreviewAuctionJoiningLoading extends PreviewAuctionState {}

// Bidding states
final class PreviewAuctionBiddingLoading extends PreviewAuctionState {}

// Withdrawal states
final class PreviewAuctionWithdrawalLoading extends PreviewAuctionState {}

final class PreviewAuctionWithdrawalSuccess extends PreviewAuctionState {
  final String message;
  
  const PreviewAuctionWithdrawalSuccess(this.message);
}
