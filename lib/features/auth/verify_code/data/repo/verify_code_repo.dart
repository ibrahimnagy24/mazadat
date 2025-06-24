import 'package:dartz/dartz.dart';
import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../login/data/entity/user_entity.dart';
import '../../../login/data/model/user_model.dart';
import '../models/send_code_model.dart';
import '../params/send_code_params.dart';
import '../params/verify_code_params.dart';

abstract class VerifyCodeRepo {
  const VerifyCodeRepo();
  static Future<Either<ErrorEntity, UserEntity>> verifyCode(
      VerifyCodeParams params) async {
    try {
      final response = await Network().request(
        Endpoints.verifyCode,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );

      return Right(UserModel.fromJson(
        response.data['USER'],
        token: response.data['TOKEN'],
      ));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, SendCodeModel>> sendVerifyCode(
      SendCodeParams params) async {
    try {
      final response = await Network().request(
        Endpoints.resendCode,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );
      return Right(SendCodeModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
