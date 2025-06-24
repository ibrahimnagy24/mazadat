import 'package:dartz/dartz.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/utility.dart';
import '../entity/home_auction_entity.dart';
import '../model/home_auction_model.dart';
import '../params/home_auction_params.dart';

abstract class HomeRepo {
  static Future<Either<ErrorEntity, List<HomeAuctionEntity>>> auction(
      HomeAuctionParams params) async {
    try {
      final response = await Network().request(
        params.endPoint,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );

      final List<HomeAuctionEntity> auctions =
          checkFromArray(response.data['content'])
              ? (response.data['content'] as List)
                  .map((e) => HomeAuctionModel.fromJson(e))
                  .toList()
              : [];

      return Right(auctions);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
