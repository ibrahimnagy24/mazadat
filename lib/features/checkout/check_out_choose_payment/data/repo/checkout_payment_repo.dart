import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../entity/checkout_payment_entity.dart';
import '../entity/confirm_checkout_entity.dart';
import '../entity/payment_status_entity.dart';
import '../model/checkout_payment_model.dart';
import '../model/confirm_checkout_model.dart';
import '../model/payment_status_model.dart';
import '../params/checkout_payment_params.dart';
import '../params/confirm_checkout_params.dart';
import '../params/payment_status_params.dart';

abstract class CheckoutPaymentRepo {
  static Future<Either<ErrorEntity, CheckoutPaymentEntity>>
      getPaymentMethods(GetCheckoutPaymentMethodsParams params) async {
    try {
      final response = await Network().request(
        Endpoints.paymentList,
        method: ServerMethods.GET,
        queryParameters: params.toJson(),
      );

      final paymentMethods = CheckoutPaymentModel.fromJson(response.data);
      return Right(paymentMethods);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, Response>> selectPaymentMethod(
    SelectPaymentMethodParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.selectPaymentMethod,
        method: ServerMethods.POST,
        body: params.toJson(),
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

  static Future<Either<ErrorEntity, ConfirmCheckoutEntity>> confirmCheckout(
    ConfirmCheckoutParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.confirmAuctionCheckout,
        method: ServerMethods.POST,
        body: params.toJson(),
      );

      final confirmCheckout = ConfirmCheckoutModel.fromJson(response.data);
      return Right(confirmCheckout);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, PaymentStatusEntity>> getPaymentStatus(
    PaymentStatusParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.getAuctionCheckoutPaymentStatus,
        method: ServerMethods.POST,
        body: params.toJson(),
      );

      final paymentStatus = PaymentStatusModel.fromJson(response.data);
      return Right(paymentStatus);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
