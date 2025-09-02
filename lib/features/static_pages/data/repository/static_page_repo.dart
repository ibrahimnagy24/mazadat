import 'package:dartz/dartz.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../entities/static_page_entity.dart';
import '../models/static_page_model.dart';
import '../params/static_page_params.dart';

class StaticPageRepo {
  const StaticPageRepo();

  static Future<Either<ErrorEntity, StaticPageEntity>> staticPage(
      StaticPageParams params) async {
    try {
      final response = await Network().request(
        params.url,
        method: ServerMethods.GET,
      );

      return Right(StaticPageModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
