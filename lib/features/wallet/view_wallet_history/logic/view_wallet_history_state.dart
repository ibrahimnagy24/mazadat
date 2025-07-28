import '../../../../core/shared/entity/error_entity.dart';
import '../data/entity/wallet_history_entity.dart';

sealed class ViewWalletHistoryState {
  const ViewWalletHistoryState();
}

final class ViewWalletHistoryInitial extends ViewWalletHistoryState {}

final class ViewWalletHistoryLoading extends ViewWalletHistoryState {
  const ViewWalletHistoryLoading();
}

final class ViewWalletHistorySuccess extends ViewWalletHistoryState {
  final List<WalletHistoryEntity> wallets;
  const ViewWalletHistorySuccess(this.wallets);
}

final class ViewWalletHistoryError extends ViewWalletHistoryState {
  final ErrorEntity error;
  const ViewWalletHistoryError(this.error);
}
