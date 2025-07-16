import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/app_core.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../../core/shared/entity/error_entity.dart';
import '../../../core/utils/enums/enums.dart';
import '../../../core/utils/widgets/dialogs/loading_dialog.dart';
import '../data/repo/auction_manual_bidding_repo.dart';
part 'auction_manual_bidding_cubit.dart';

sealed class AuctionManualBiddingState extends Equatable {
  const AuctionManualBiddingState();

  @override
  List<Object> get props => [];
}

class AuctionManualBiddingInitial extends AuctionManualBiddingState {}

class AuctionManualBiddingLoading extends AuctionManualBiddingState {}

class AuctionManualBiddingSuccess extends AuctionManualBiddingState {
  const AuctionManualBiddingSuccess();
}

class AuctionManualBiddingError extends AuctionManualBiddingState {
  final ErrorEntity error;
  const AuctionManualBiddingError(this.error);
}
