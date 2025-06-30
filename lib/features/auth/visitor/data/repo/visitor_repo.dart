import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../model/visitor_model.dart';
import '../params/visitor_login_params.dart';

abstract class VisitorRepo {
  const VisitorRepo();

  static Future<Either<ErrorEntity, VisitorModel>> login(
      VisitorLoginParams params) async {
    try {

      final response = await Network().request(
        Endpoints.visitor,
        method: ServerMethods.POST,
        body: params.returnedMap(),
      );
      return Right(VisitorModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
