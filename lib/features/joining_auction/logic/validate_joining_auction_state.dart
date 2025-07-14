import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/app_core.dart';
import '../../../core/shared/entity/error_entity.dart';
import '../../../core/utils/constant/app_strings.dart';
import '../../../core/utils/extensions/extensions.dart';
import '../data/model/auction_policy_model.dart';
import '../data/repo/joining_auction_repo.dart';

part 'validate_joining_auction_cubit.dart';

sealed class ValidateJoiningAuctionState extends Equatable {
  const ValidateJoiningAuctionState();

  @override
  List<Object> get props => [];
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
