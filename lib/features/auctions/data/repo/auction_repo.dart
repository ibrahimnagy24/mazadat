import 'package:dartz/dartz.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/utility.dart';
import '../entity/auction_entity.dart';
import '../model/auction_model.dart';
import '../params/auction_params.dart';

abstract class AuctionRepo {
  static Future<Either<ErrorEntity, List<AuctionEntity>>> auction(
      AuctionParams? params) async {
    // try {
      final response = await Network().request(
        Endpoints.homeAuction,
        method: ServerMethods.GET,
        queryParameters: params?.returnedMap(),
      );

      final List<AuctionEntity> auctions =
          checkFromArray(response.data['content'])
              ? (response.data['content'] as List)
                  .map((e) => AuctionModel.fromJson(e))
                  .toList()
              : [];

      return Right(auctions);
    // } catch (error) {
    //   return Left(ApiErrorHandler().handleError(error));
    // }
  }
}
