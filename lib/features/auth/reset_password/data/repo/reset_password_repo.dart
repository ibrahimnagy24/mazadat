import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../models/reset_password_model.dart';
import '../params/reset_password_params.dart';

abstract class ResetPasswordRepo {
  const ResetPasswordRepo();
  static Future<Either<ErrorEntity, ResetPasswordModel>> resetPassword(
      ResetPasswordParams params) async {
    try {
      final response = await Network().request(
        Endpoints.resetPassword,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );
      return Right(ResetPasswordModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
