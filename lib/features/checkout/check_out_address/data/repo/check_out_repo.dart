import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../model/checkout_model.dart';
import '../params/checkout_address_params.dart';

abstract class CheckOutRepo {
  const CheckOutRepo();

  static Future<Either<ErrorEntity, CheckoutModel>> setDefaultAddress(
      CheckoutAddressParams params) async {
    try {
      final response = await Network().request(
        Endpoints.setDefaultAddress,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );

      return Right(CheckoutModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
