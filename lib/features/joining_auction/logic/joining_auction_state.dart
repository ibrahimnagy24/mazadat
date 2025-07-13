import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/shared/entity/error_entity.dart';
import '../data/model/auction_policy_model.dart';
import '../data/repo/joining_auction_repo.dart';
part  'joining_auction_cubit.dart';

sealed class JoiningAuctionState extends Equatable {
  const JoiningAuctionState();

  @override
  List<Object> get props => [];
}

class JoiningAuctionInitial extends JoiningAuctionState {}

class JoiningAuctionLoading extends JoiningAuctionState {}

class JoiningAuctionSuccess extends JoiningAuctionState {
  final AuctionPolicyModel data;
  const JoiningAuctionSuccess({required this.data});
}

class JoiningAuctionError extends JoiningAuctionState {
  final ErrorEntity error;
  const JoiningAuctionError(this.error);
}
