import 'package:dartz/dartz.dart';

import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../auth/login/data/entity/user_entity.dart';
import '../../../auth/login/data/model/user_model.dart';

class UserRepo {
  const UserRepo();
  static Future<Either<ErrorEntity, UserEntity>> getUserData() async {
    // try {
      final response = await Network().request(
        Endpoints.getUserInfo,
        method: ServerMethods.GET,
      );
      final UserEntity user = UserModel.fromJson(response.data['DATA']);
      return Right(user);
    // } catch (error) {
    //   return Left(ApiErrorHandler().handleError(error));
    // }
  }
}
