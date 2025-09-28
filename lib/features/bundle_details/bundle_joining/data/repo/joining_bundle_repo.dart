import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../choose_bundle_payment/data/entity/submit_joining_response_entity.dart';
import '../../../choose_bundle_payment/data/model/submit_joining_response_model.dart';
import '../params/check_insurance_payment_params.dart';
import '../params/validate_bundle_params.dart';

abstract class JoiningBundleRepo {
  static Future<Either<ErrorEntity, Response>> validateJoiningBundle(
      ValidateBundleParams params) async {
    try {
      final response = await Network().request(
        Endpoints.validateBundleJoining,
        method: ServerMethods.POST,
        body: params.returnedMap(),
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

  static Future<Either<ErrorEntity, SubmitJoiningResponseEntity>> submitJoining(
      Map<String, dynamic> data) async {
    try {
      final response = await Network().request(
        Endpoints.submitJoiningBundle,
        method: ServerMethods.POST,
        body: data,
      );

      if (response.statusCode == 200) {
        final model = SubmitJoiningResponseModel.fromJson(response.data);
        return Right(model);
      } else {
        return Left(ApiErrorHandler().handleError(response.data['message']));
      }
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  // static Future<Either<ErrorEntity, Response>> checkOnJoining(
  //     Map<String, dynamic> data) async {
  //   try {
  //     final response = await Network().request('/bundles/checkInsurancePayment',
  //         method: ServerMethods.POST, body: data);

  //     if (response.statusCode == 200) {
  //       return Right(response);
  //     } else {
  //       return Left(ApiErrorHandler().handleError(response.data['message']));
  //     }
  //   } catch (error) {
  //     return Left(ApiErrorHandler().handleError(error));
  //   }
  // }

  static Future<Either<ErrorEntity, Response>> checkInsurancePayment(
      CheckInsurancePaymentParams params) async {
    try {
      final response = await Network().request(
        Endpoints.checkBundleInsurancePayment,
        method: ServerMethods.POST,
        body: params.returnedMap(),
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
