import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_core.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/widgets/dialogs/loading_dialog.dart';
import '../data/repo/auction_withdrawal_bidding_repo.dart';
part 'auction_withdrawal_cubit.dart';

sealed class AuctionWithdrawalState extends Equatable {
  const AuctionWithdrawalState();

  @override
  List<Object> get props => [];
}

class AuctionWithdrawalInitial extends AuctionWithdrawalState {}

class AuctionWithdrawalLoading extends AuctionWithdrawalState {}

class AuctionWithdrawalSuccess extends AuctionWithdrawalState {
  const AuctionWithdrawalSuccess();
}

class AuctionWithdrawalError extends AuctionWithdrawalState {
  final ErrorEntity error;
  const AuctionWithdrawalError(this.error);
}
