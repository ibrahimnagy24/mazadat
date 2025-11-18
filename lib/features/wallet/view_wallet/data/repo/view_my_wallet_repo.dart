import 'package:dartz/dartz.dart';
import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../entity/view_my_wallet_entity.dart';
import '../model/charge_balance_model.dart';
import '../model/check_wallet_charge_model.dart';
import '../model/view_my_wallet_model.dart';
import '../params/charge_balance_params.dart';
import '../params/check_wallet_charge_params.dart';
import '../params/view_wallet_params.dart';

abstract class ViewMyWalletRepo {
  const ViewMyWalletRepo();

  static Future<Either<ErrorEntity, ViewMyWalletEntity>> viewMyWallet(
      ViewWalletParams params) async {
    try {
      final response = await Network().request(
        Endpoints.walletHistory,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );
      return Right(ViewMyWalletModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, ChargeBalanceModel>> chargeWallet(
      ChargeBalanceParams params) async {
    try {
      final response = await Network().request(
        Endpoints.chargeWallet,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );
      return Right(ChargeBalanceModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, CheckWalletChargeModel>> checkWalletCharge(
      CheckWalletChargeParams params) async {
    try {
      final response = await Network().request(
        Endpoints.checkWalletCharge,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );
      return Right(CheckWalletChargeModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
