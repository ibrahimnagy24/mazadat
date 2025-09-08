import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/widgets/dialogs/custom_simple_dialog.dart';
import '../../../../core/utils/widgets/dialogs/loading_dialog.dart';
import '../data/repo/joining_auction_repo.dart';
import '../ui/widgets/payment_success_dialog.dart';
part 'check_on_joining_auction_cubit.dart';

sealed class CheckOnJoiningAuctionState extends Equatable {
  const CheckOnJoiningAuctionState();

  @override
  List<Object> get props => [];
}

class CheckOnJoiningAuctionInitial extends CheckOnJoiningAuctionState {}

class CheckOnJoiningAuctionLoading extends CheckOnJoiningAuctionState {}

class CheckOnJoiningAuctionSuccess extends CheckOnJoiningAuctionState {
  const CheckOnJoiningAuctionSuccess();
}

class CheckOnJoiningAuctionError extends CheckOnJoiningAuctionState {
  final ErrorEntity error;
  const CheckOnJoiningAuctionError(this.error);
}
