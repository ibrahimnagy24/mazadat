import 'package:dartz/dartz.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/utility.dart';
import '../entities/static_page_entity.dart';
import '../models/static_page_model.dart';
import '../params/static_page_params.dart';

class StaticPageRepo {
  const StaticPageRepo();

  static Future<Either<ErrorEntity, List<StaticPageEntity>>> staticPage(
      StaticPageParams params) async {
    try {
      final response = await Network().request(
        params.url,
        method: ServerMethods.GET,
      );

      final List<StaticPageEntity> data = checkFromArray(response.data['data'])
          ? (response.data['data'] as List)
              .map((e) => StaticPageModel.fromJson(e))
              .toList()
          : [];

      return Right(data);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
