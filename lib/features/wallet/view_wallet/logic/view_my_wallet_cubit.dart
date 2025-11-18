import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../data/entity/view_my_wallet_entity.dart';
import '../data/params/charge_balance_params.dart';
import '../data/params/check_wallet_charge_params.dart';
import '../data/params/view_wallet_params.dart';
import '../data/repo/view_my_wallet_repo.dart';
import 'view_my_wallet_state.dart';

class ViewMyWalletCubit extends Cubit<ViewMyWalletState> {
  ViewMyWalletCubit() : super(ViewMyWalletInitial());
//---------------------------------VARIABLES----------------------------------//
  ViewMyWalletEntity? viewMyWalletEntity;
  int page = 0;
  int size = 10;

//---------------------------------FUNCTIONS----------------------------------//

//----------------------------------REQUEST-----------------------------------//

  Future<void> viewMyWalletStatesHandled({ViewWalletParams? params}) async {
    CustomNavigator.context.loaderOverlay.show();
    emit(ViewMyWalletLoading());
    final response = await ViewMyWalletRepo.viewMyWallet(
        params ?? ViewWalletParams(page: page));
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(ViewMyWalletError(failure));
    }, (success) async {
      CustomNavigator.context.loaderOverlay.hide();
      viewMyWalletEntity = success;
      return emit(ViewMyWalletSuccess(success));
    });
  }

  Future<void> chargeWalletStatesHandled(ChargeBalanceParams params) async {
    CustomNavigator.context.loaderOverlay.show();
    emit(const ChargeWalletLoading());
    final response = await ViewMyWalletRepo.chargeWallet(params);
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(ChargeWalletError(failure));
    }, (success) async {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(ChargeWalletSuccess(success));
    });
  }

  Future<void> checkWalletChargeStatesHandled(
      CheckWalletChargeParams params) async {
    CustomNavigator.context.loaderOverlay.show();
    emit(const CheckWalletChargeLoading());
    final response = await ViewMyWalletRepo.checkWalletCharge(params);
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(CheckWalletChargeError(failure));
    }, (success) async {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(CheckWalletChargeSuccess(success));
    });
  }
}
