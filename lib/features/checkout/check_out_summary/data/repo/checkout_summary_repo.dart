import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../entity/checkout_summary_entity.dart';
import '../entity/validate_summary_entity.dart';
import '../model/checkout_summary_model.dart';
import '../model/validate_summary_model.dart';
import '../params/get_checout_summary_params.dart';
import '../params/validate_summary_params.dart';

abstract class CheckoutSummaryRepo {
  const CheckoutSummaryRepo();
  static Future<Either<ErrorEntity, CheckoutSummaryEntity>> getCheckoutSummary(
      GetCheckoutSummaryParams params) async {
    try {
      final response = await Network().request(
        Endpoints.checkoutSummary,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );
      return Right(CheckoutSummaryModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, ValidateSummaryEntity>> validateSummary(
      ValidateSummaryParams params) async {
    try {
      final response = await Network().request(
        Endpoints.validateSummary,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );
      return Right(ValidateSummaryModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
