import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/entity/wallet_history_entity.dart';
import '../data/repo/wallet_history_repo.dart';
import 'view_wallet_history_state.dart';

class ViewWalletHistoryCubit extends Cubit<ViewWalletHistoryState> {
  ViewWalletHistoryCubit() : super(ViewWalletHistoryInitial());
//---------------------------------VARIABLES----------------------------------//
  List<WalletHistoryEntity>? walletHistory;
//---------------------------------FUNCTIONS----------------------------------//

//----------------------------------REQUESTS----------------------------------//
  Future<void> viewHistoryStatesHandled() async {
    emit(const ViewWalletHistoryLoading());
    final response = await WalletHistoryRepo.walletHistory();
    response.fold((failure) {
      return emit(ViewWalletHistoryError(failure));
    }, (success) async {
      walletHistory = success;
      return emit(ViewWalletHistorySuccess(success));
    });
  }
}
