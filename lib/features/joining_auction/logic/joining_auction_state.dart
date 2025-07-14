import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../../core/shared/entity/error_entity.dart';
import '../../../core/utils/widgets/dialogs/loading_dialog.dart';
import '../../check_out/data/model/payment_model.dart';
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
  const JoiningAuctionSuccess();
}

class JoiningAuctionError extends JoiningAuctionState {
  final ErrorEntity error;
  const JoiningAuctionError(this.error);
}
