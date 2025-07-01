import 'package:dartz/dartz.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/utility.dart';
import '../entity/bundle_entity.dart';
import '../model/bundle_model.dart';
import '../params/bundle_params.dart';

abstract class BundlesRepo {
  static Future<Either<ErrorEntity, List<BundleEntity>>> bundles(
      BundleParams? params) async {
    try {
      final response = await Network().request(
        Endpoints.homeBundles,
        method: ServerMethods.GET,
        queryParameters: params?.returnedMap(),
      );

      final List<BundleEntity> auctions =
          checkFromArray(response.data['content'])
              ? (response.data['content'] as List)
                  .map((e) => BundleModel.fromJson(e))
                  .toList()
              : [];

      return Right(auctions);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
