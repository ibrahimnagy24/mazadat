import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../models/change_password_model.dart';
import '../params/change_password_params.dart';

abstract class ChangePasswordRepo {
  const ChangePasswordRepo();
  static Future<Either<ErrorEntity, ChangePasswordModel>> changePassword(
      ChangePasswordParams params) async {
    try {
      final response = await Network().request(
        Endpoints.resetPassword,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );
      return Right(ChangePasswordModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
