import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../models/forget_password_model.dart';
import '../params/forget_password_params.dart';

abstract class ForgetPasswordRepo {
  const ForgetPasswordRepo();
  static Future<Either<ErrorEntity, ForgetPasswordModel>> forgetPassword(
      ForgetPasswordParams params) async {
    try {
      final response = await Network().request(
        Endpoints.forgotPassword,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );
      return Right(ForgetPasswordModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
