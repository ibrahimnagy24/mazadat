
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/app_core.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../../core/shared/entity/error_entity.dart';
import '../../../core/utils/enums/enums.dart';
import '../../../core/utils/widgets/dialogs/loading_dialog.dart';
import '../data/repo/auction_first_bidding_repo.dart';
part 'auction_first_bidding_cubit.dart';

sealed class AuctionFirstBiddingState extends Equatable {
  const AuctionFirstBiddingState();

  @override
  List<Object> get props => [];
}

class AuctionFirstBiddingInitial extends AuctionFirstBiddingState {}

class AuctionFirstBiddingLoading extends AuctionFirstBiddingState {}

class AuctionFirstBiddingSuccess extends AuctionFirstBiddingState {
  const AuctionFirstBiddingSuccess();
}

class AuctionFirstBiddingError extends AuctionFirstBiddingState {
  final ErrorEntity error;
  const AuctionFirstBiddingError(this.error);
}
