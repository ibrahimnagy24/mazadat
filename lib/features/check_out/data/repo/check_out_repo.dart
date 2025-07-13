import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';

abstract class CheckOutRepo {
  static Future<Either<ErrorEntity, Response>> getPaymentList() async {
    try {
      final response = await Network().request(
        Endpoints.paymentList,
        method: ServerMethods.GET,
      );

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return Left(ApiErrorHandler().handleError(response.data['message']));
      }
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
