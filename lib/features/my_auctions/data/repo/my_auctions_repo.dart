import 'package:dartz/dartz.dart';

import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/utility.dart';
import '../entity/my_auction_entity.dart';
import '../model/my_auction_model.dart';
import '../params/my_auctions_params.dart';

abstract class MyAuctionsRepo {
  const MyAuctionsRepo();

  static Future<Either<ErrorEntity, List<MyAuctionEntity>>> myAuctions(
    MyAuctionsParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.myAuctions,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );

      final List<MyAuctionEntity> data =
          checkFromArray(response.data['content'])
              ? (response.data['content'] as List)
                  .map((e) => MyAuctionModel.fromJson(e))
                  .toList()
              : [];

      return Right(data);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
