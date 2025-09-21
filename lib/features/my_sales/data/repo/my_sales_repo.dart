import 'package:dartz/dartz.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../entity/auction_entity.dart';
import '../model/auction_model.dart';
import '../params/auction_params.dart';

abstract class MySalesRepo {
  static Future<Either<ErrorEntity, List<AuctionEntity>>> getAuctions(
      AuctionParams params) async {
    try {
      final response = await Network().request(
        Endpoints.filterMySales,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );

      final AuctionsResponseModel auctionsResponse =
          AuctionsResponseModel.fromJson(response.data);

      return Right(auctionsResponse.content);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
