import 'package:dartz/dartz.dart';

import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/utility.dart';
import '../entity/home_auction_entity.dart';
import '../entity/home_bundle_entity.dart';
import '../model/home_auction_model.dart';
import '../model/home_bundle_model.dart';
import '../params/home_auction_params.dart';
import '../params/home_bundle_params.dart';

abstract class HomeRepo {
  static Future<Either<ErrorEntity, List<HomeAuctionEntity>>> homeAuction(
      HomeAuctionParams params) async {
    try {
      final response = await Network().request(
        Endpoints.homeAuction,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );

      final List<HomeAuctionEntity> data =
          checkFromArray(response.data['content'])
              ? (response.data['content'] as List)
                  .map((e) => HomeAuctionModel.fromJson(e))
                  .toList()
              : [];

      return Right(data);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }

  static Future<Either<ErrorEntity, List<HomeBundleEntity>>> bundles(
      HomeBundleParams params) async {
    try {
      final response = await Network().request(
        Endpoints.homeBundles,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );

      final List<HomeBundleEntity> data =
          checkFromArray(response.data['content'])
              ? (response.data['content'] as List)
                  .map((e) => HomeBundleModel.fromJson(e))
                  .toList()
              : [];

      return Right(data);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
