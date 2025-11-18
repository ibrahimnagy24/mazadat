import '../../../../core/shared/entity/error_entity.dart';
import '../data/entity/view_my_wallet_entity.dart';
import '../data/model/charge_balance_model.dart';
import '../data/model/check_wallet_charge_model.dart';

sealed class ViewMyWalletState {
  const ViewMyWalletState();
}

final class ViewMyWalletInitial extends ViewMyWalletState {}

final class ViewMyWalletLoading extends ViewMyWalletState {}

final class ViewMyWalletSuccess extends ViewMyWalletState {
  final ViewMyWalletEntity viewMyWallet;
  const ViewMyWalletSuccess(this.viewMyWallet);
}

final class ViewMyWalletError extends ViewMyWalletState {
  final ErrorEntity error;
  const ViewMyWalletError(this.error);
}

final class ChargeWalletLoading extends ViewMyWalletState {
  const ChargeWalletLoading();
}

final class ChargeWalletSuccess extends ViewMyWalletState {
  final ChargeBalanceModel chargeWallet;
  const ChargeWalletSuccess(this.chargeWallet);
}

final class ChargeWalletError extends ViewMyWalletState {
  final ErrorEntity error;
  const ChargeWalletError(this.error);
}

final class CheckWalletChargeLoading extends ViewMyWalletState {
  const CheckWalletChargeLoading();
}

final class CheckWalletChargeSuccess extends ViewMyWalletState {
  final CheckWalletChargeModel checkWalletCharge;
  const CheckWalletChargeSuccess(this.checkWalletCharge);
}

final class CheckWalletChargeError extends ViewMyWalletState {
  final ErrorEntity error;
  const CheckWalletChargeError(this.error);
}
