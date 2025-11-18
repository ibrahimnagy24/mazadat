import 'package:dartz/dartz.dart';
import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../user/data/model/user_model.dart';
import '../params/edit_profile_params.dart';

abstract class EditProfileRepo {
  const EditProfileRepo();
  static Future<Either<ErrorEntity, UserModel>> editProfile(
      EditProfileParams params) async {
    try {
      final response = await Network().request(
        Endpoints.updateUserInfo,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );

      final UserModel user = UserModel.fromJson(response.data['DATA']);
      return Right(user);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
