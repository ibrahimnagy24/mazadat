import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../models/change_phone_number_model.dart';
import '../params/change_phone_number_params.dart';

abstract class ChangePhoneNumberRepo {
  const ChangePhoneNumberRepo();
  static Future<Either<ErrorEntity, ChangePhoneNumberModel>> changePhoneNumber(
      ChangePhoneNumberParams params) async {
    try {
      final response = await Network().request(
        Endpoints.changePhoneNumber,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );
      return Right(ChangePhoneNumberModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
