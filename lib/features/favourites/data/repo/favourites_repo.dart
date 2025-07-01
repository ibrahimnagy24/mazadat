import 'package:dartz/dartz.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/utility.dart';
import '../../../auctions/data/entity/auction_entity.dart';
import '../../../auctions/data/model/auction_model.dart';
import '../params/favourites_params.dart';

abstract class FavouritesRepo {
  static Future<Either<ErrorEntity, List<AuctionEntity>>> favouritesAuction(
      FavouritesParams? params) async {
    try {
      final response = await Network().request(
        Endpoints.auctions,
        method: ServerMethods.GET,
        queryParameters: params?.returnedMap(),
      );

      final List<AuctionEntity> auctions = checkFromArray(response.data)
          ? (response.data as List)
              .map((e) => AuctionModel.fromJson(e))
              .toList()
          : [];

      return Right(auctions);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
