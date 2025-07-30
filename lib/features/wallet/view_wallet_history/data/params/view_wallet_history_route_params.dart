import 'package:equatable/equatable.dart';

import '../../../view_wallet/logic/view_my_wallet_cubit.dart';

class ViewWalletHistoryRouteParams extends Equatable {
  final ViewMyWalletCubit viewMyWalletCubit;

  const ViewWalletHistoryRouteParams({required this.viewMyWalletCubit});

  @override
  List<Object?> get props => [viewMyWalletCubit];
}
