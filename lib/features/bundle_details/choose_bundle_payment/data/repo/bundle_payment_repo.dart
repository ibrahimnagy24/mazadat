import 'package:dartz/dartz.dart';
import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../entity/bundle_payment_entity.dart';
import '../entity/bundle_payment_status_entity.dart';
import '../entity/submit_joining_response_entity.dart';
import '../model/bundle_payment_model.dart';
import '../model/bundle_payment_status_model.dart';
import '../model/submit_joining_response_model.dart';
import '../params/bundle_payment_params.dart';
import '../params/bundle_payment_status_params.dart';
import '../params/submit_joining_payment_params.dart';

abstract class BundlePaymentRepo {
  static Future<Either<ErrorEntity, BundlePaymentEntity>> getPaymentMethods(
      GetBundlePaymentMethodsParams params) async {
    try {
      final response = await Network().request(
        Endpoints.paymentList,
        method: ServerMethods.GET,
        queryParameters: params.toJson(),
      );

      final paymentMethods = BundlePaymentModel.fromJson(response.data);
      return Right(paymentMethods);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, SubmitJoiningResponseEntity>> submitJoining(
      SubmitJoiningPaymentParams params) async {
    try {
      final response = await Network().request(
        Endpoints.submitJoiningBundle,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );

      final model = SubmitJoiningResponseModel.fromJson(response.data);
      return Right(model);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, BundlePaymentStatusEntity>>
      getBundlePaymentStatus(BundlePaymentStatusParams params) async {
    try {
      final response = await Network().request(
        Endpoints.getBundleCheckoutPaymentStatus,
        method: ServerMethods.POST,
        body: params.toJson(),
      );

      final paymentStatus = BundlePaymentStatusModel.fromJson(response.data);
      return Right(paymentStatus);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
