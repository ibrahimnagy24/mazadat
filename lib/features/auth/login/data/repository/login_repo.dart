import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../../user/data/entity/user_entity.dart';
import '../../../../user/data/model/user_model.dart';
import '../params/login_params.dart';

abstract class LoginRepo {
  const LoginRepo();
  static Future<Either<ErrorEntity, UserEntity>> login(
      LoginParams params) async {
    try {
      final response = await Network().request(
        Endpoints.login,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );
      final UserEntity user = UserModel.fromJson(
        response.data['USER'],
        token: response.data['TOKEN'],
        message: response.data['MESSAGE'],
      );
      return Right(user);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
