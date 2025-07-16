import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/app_core.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../../core/shared/entity/error_entity.dart';
import '../../../core/utils/enums/enums.dart';
import '../../../core/utils/widgets/dialogs/loading_dialog.dart';
import '../data/repo/auction_switch_bidding_repo.dart';
part 'auction_switch_bidding_cubit.dart';

sealed class AuctionSwitchBiddingState extends Equatable {
  const AuctionSwitchBiddingState();

  @override
  List<Object> get props => [];
}

class AuctionSwitchBiddingInitial extends AuctionSwitchBiddingState {}

class AuctionSwitchBiddingLoading extends AuctionSwitchBiddingState {}

class AuctionFirstBiddingSuccess extends AuctionSwitchBiddingState {
  const AuctionFirstBiddingSuccess();
}

class AuctionSwitchBiddingError extends AuctionSwitchBiddingState {
  final ErrorEntity error;
  const AuctionSwitchBiddingError(this.error);
}
