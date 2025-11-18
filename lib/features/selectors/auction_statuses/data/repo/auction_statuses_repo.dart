import 'package:dartz/dartz.dart';
import '../../../../../../core/app_config/api_names.dart';
import '../../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../../core/services/network/network_helper.dart';
import '../../../../../../core/shared/entity/error_entity.dart';
import '../../../../../../core/utils/utility.dart';
import '../entity/auction_status_entity.dart';
import '../model/auction_status_model.dart';

abstract class AuctionStatusesRepo {
  const AuctionStatusesRepo();

  static Future<Either<ErrorEntity, List<AuctionStatusEntity>>>
      getAuctionStatuses() async {
    try {
      final response = await Network().request(
        Endpoints.auctionStatuses,
        method: ServerMethods.GET,
      );
      final List<AuctionStatusEntity> user =
          checkFromArray(response.data['AUCTION_STATUS'])
              ? (response.data['AUCTION_STATUS'] as List)
                  .map((e) => AuctionStatusModel.fromJson(e))
                  .toList()
              : [];
      return Right(user);
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
